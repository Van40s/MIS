import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lab_04_211244_v2/service/notification_service.dart';

final NotificationService notificationService = NotificationService();

Future<void> checkProximity(LatLng targetLocation, double radiusInMeters) async {
  Position userPosition = await Geolocator.getCurrentPosition();

  double distance = Geolocator.distanceBetween(
    userPosition.latitude,
    userPosition.longitude,
    targetLocation.latitude,
    targetLocation.longitude,
  );

  if (distance <= radiusInMeters) {
    await notificationService.showNotification(
      title: 'Reminder!',
      body: 'You are near your reminder location.',
    );
  }
}
