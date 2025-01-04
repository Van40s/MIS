import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  String id; // Firebase document ID
  String examId; // Link to the Exam document
  double radius; // Radius in meters for location-based trigger
  bool isActive; // Whether the reminder is active

  Reminder({
    required this.id,
    required this.examId,
    required this.radius,
    this.isActive = true, // Default to true when creating
  });

  // Converts Firebase data to Reminder model
  factory Reminder.fromMap(String id, Map<String, dynamic> data) {
    return Reminder(
      id: id,
      examId: data['examId'],
      radius: data['radius'].toDouble(),
      isActive: data['isActive'] ?? true, // Default to true if null
    );
  }

  // Converts Reminder model to Firebase data
  Map<String, dynamic> toMap() {
    return {
      'examId': examId,
      'radius': radius,
      'isActive': isActive,
    };
  }
}
