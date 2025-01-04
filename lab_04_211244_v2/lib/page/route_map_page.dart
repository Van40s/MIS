import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab_04_211244_v2/models/exam.dart';

class RouteMapPage extends StatefulWidget {
  final Exam exam;  // Now accept Exam instead of LatLng

  RouteMapPage({required this.exam}) {
        print("RouteMapPage constructor called with exam: ${exam.toString()}");
  }

  @override
  _RouteMapPageState createState() => _RouteMapPageState();
}

class _RouteMapPageState extends State<RouteMapPage> {
  List<LatLng> routeCoordinates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
      print("initState called");
    fetchRoute();
  }

  // Fetch user's current location
Future<Position> _getUserLocation() async {
  try {
    print("entered this location user 1");

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    print("entered this location user 2");

    // Check permission status before requesting permission
    LocationPermission permissionStatus = await Geolocator.checkPermission();
    print("Current permission status: $permissionStatus");

    if (permissionStatus == LocationPermission.denied) {
      permissionStatus = await Geolocator.requestPermission();
      print("Requested permission: $permissionStatus");
      if (permissionStatus == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    print("entered this location user 3");

    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);
    return position;
  } catch (e) {
    print("Error in _getUserLocation: $e");
    rethrow;
  }
}

  // Fetch route from OSRM API
  Future<void> fetchRoute() async {
    try {
      print("FETCH USER ENTERED");
      Position userPosition = await _getUserLocation();
      print("POSLE USER LOCATION");
      print(userPosition.longitude);
      print(userPosition.latitude);

      print("TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST");
      print(widget.exam.location.latitude);
      print(widget.exam.location.longitude);
      // Extract coordinates for start and end locations
      final startLocation = LatLng(userPosition.latitude, userPosition.longitude);
      final endLocation = LatLng(
        widget.exam.location.latitude,  // Use the exam's location (GeoPoint)
        widget.exam.location.longitude,
      );

      final url =
          'https://router.project-osrm.org/route/v1/driving/${startLocation.longitude},${startLocation.latitude};${endLocation.longitude},${endLocation.latitude}?overview=full&geometries=geojson';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> coordinates =
            data['routes'][0]['geometry']['coordinates'];

        setState(() {
          routeCoordinates = coordinates
              .map((coord) => LatLng(coord[1], coord[0]))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch route');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching route: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shortest Route')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: routeCoordinates.isNotEmpty
                    ? routeCoordinates.first
                    : LatLng(0.0, 0.0),  // Default center if no route
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeCoordinates,
                      color: Colors.blue,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    // Marker for user's location
                    Marker(
                      point: LatLng(routeCoordinates.first.latitude, routeCoordinates.first.longitude),
                      builder: (ctx) => Icon(Icons.location_on, color: Colors.green),
                    ),
                    // Marker for exam's location
                    Marker(
                      point: LatLng(widget.exam.location.latitude, widget.exam.location.longitude),
                      builder: (ctx) => Icon(Icons.location_on, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
