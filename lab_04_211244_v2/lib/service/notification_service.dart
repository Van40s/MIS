import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_04_211244_v2/models/exam.dart';
import 'package:lab_04_211244_v2/models/reminder.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); // Replace with your app icon
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> setReminder(Exam exam, {double radius = 1000}) async {
    // Add reminder to Firestore
    await _firestore.collection('reminders').add({
      'examId': exam.id,
      'radius': radius,
      'isActive': true,
    });
    // Start monitoring location
    _startLocationMonitoring(exam, radius);
  }

  void _startLocationMonitoring(Exam exam, double radius) {
    Geolocator.getPositionStream().listen((Position position) async {
      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        exam.location.latitude,
        exam.location.longitude,
      );

      // If within radius, trigger notification
      if (distance <= radius) {
        showNotification(
          title: 'Reminder: ${exam.title}',
          body: 'You are near the location for ${exam.title}.',
        );
      }

      // Disable reminder if exam datetime has passed
      if (DateTime.now().isAfter(exam.datetime)) {
        await _deactivateReminder(exam.id);
      }
    });
  }

  Future<void> _deactivateReminder(String examId) async {
    final snapshot = await _firestore
        .collection('reminders')
        .where('examId', isEqualTo: examId)
        .get();
    for (final doc in snapshot.docs) {
      await doc.reference.update({'isActive': false});
    }
  }

  Future<void> showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'notification_icon', // Ensure this matches the filename in res/drawable
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
