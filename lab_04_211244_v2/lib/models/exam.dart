import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  String id; // Firebase document ID
  String title;
  DateTime datetime; // Store as DateTime
  GeoPoint location; // GeoPoint

  Exam({
    required this.id,
    required this.title,
    required this.datetime, // DateTime
    required this.location, // GeoPoint
  });

  // Converts Firebase data to Exam model
  factory Exam.fromMap(String id, Map<String, dynamic> data) {
    return Exam(
      id: id,
      title: data['title'],
      datetime: (data['datetime'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      location: data['location'], // GeoPoint
    );
  }

  // Converts Exam model to Firebase data
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'datetime': Timestamp.fromDate(datetime), // Store as Timestamp
      'location': location, // Store GeoPoint
    };
  }
}
