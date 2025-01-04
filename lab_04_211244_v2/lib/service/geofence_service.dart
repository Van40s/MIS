import 'package:geolocator/geolocator.dart';
import 'notification_service.dart';
import 'package:latlong2/latlong.dart';

Future<void> checkProximity(LatLng targetLocation, double radiusInMeters) async {
  Position userPosition = await Geolocator.getCurrentPosition();

  double distance = Geolocator.distanceBetween(
    userPosition.latitude,
    userPosition.longitude,
    targetLocation.latitude,
    targetLocation.longitude,
  );

  if (distance <= radiusInMeters) {
    await showNotification(
      'Reminder!',
      'You are near your reminder location.',
    );
  }
}
