import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lab_04_211244_v2/service/firebase_service.dart';
import 'package:lab_04_211244_v2/models/exam.dart';

class ExamMapPage extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exam Locations')),
      body: FutureBuilder<List<Exam>>(
        future: firebaseService.fetchExams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading exams'));
          }

          final exams = snapshot.data ?? [];

          return FlutterMap(
            options: MapOptions(
              center: LatLng(51.509865, -0.118092), // Default center (London)
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: exams.map((exam) {
                  final coords = exam.location.split(',');
                  final lat = double.parse(coords[0]);
                  final lng = double.parse(coords[1]);

                  return Marker(
                    point: LatLng(lat, lng),
                    builder: (ctx) => Icon(Icons.location_on, color: Colors.blue),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
