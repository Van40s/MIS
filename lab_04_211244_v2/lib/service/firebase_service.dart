import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_04_211244_v2/models/exam.dart';

class FirebaseService {
  final CollectionReference examsCollection =
      FirebaseFirestore.instance.collection('exams');
    
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Exam>> getExamsByDate(DateTime selectedDay) async {
  try {
    // Create a date range (start of selected day and end of selected day)
    DateTime startOfDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1)); // end of the selected day

    // Query Firestore for exams that have datetime within the selected day
    QuerySnapshot snapshot = await _firestore
        .collection('exams')
        .where('datetime', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('datetime', isLessThan: Timestamp.fromDate(endOfDay))
        .get();
    
    if (snapshot.docs.isEmpty) {
      print('No exams found for the selected date');
      return []; // No exams found, return an empty list
    }

    // Print each document's data
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      print('Exam ID: ${doc.id}');
      print('Title: ${data['title']}');
      print('Datetime: ${data['datetime']}');
      print('Location: ${data['location']}');
      print('---------------------------');
    }

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Exam(
        id: doc.id,
        title: data['title'],
        datetime: (data['datetime'] as Timestamp).toDate(), // Convert Timestamp to DateTime
        location: data['location'],
      );
    }).toList();
  } catch (e) {
    print('Error fetching exams: $e');
    return [];
  }
}

  // Add an Exam
  // Future<void> addExam(Exam exam) async {
  //   await examsCollection.add(exam.toMap());
  // }

  Future<void> addExam(Exam exam) async {
    await _firestore.collection("exams").add(exam.toMap());
  }

  Future<List<Exam>> getExams() async {
    try {
      final snapshot = await _firestore.collection('exams').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Exam(
          id: doc.id,
          title: data['title'],
          datetime: DateTime.parse(data['datetime']),
          location: data['location'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching exams: $e');
      return [];
    }
  }

  // Retrieve all Exams
  Future<List<Exam>> fetchExams() async {
    QuerySnapshot snapshot = await examsCollection.get();
    return snapshot.docs
        .map((doc) => Exam.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Delete an Exam
  Future<void> deleteExam(String id) async {
    await examsCollection.doc(id).delete();
  }
}
