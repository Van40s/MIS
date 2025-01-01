import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/jokes.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save a favorite joke
  Future<void> saveFavoriteJoke(Joke joke) async {
    try {
      final userId = 'USER_ID'; // Get the logged-in user's ID
      await _db.collection('users').doc(userId).collection('favorites').add({
        'setup': joke.setup,
        'punchline': joke.punchline,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving favorite joke: $e");
    }
  }

  // Get the favorite jokes for the logged-in user
  Future<List<Joke>> getFavoriteJokes() async {
    try {
      final userId = 'USER_ID'; // Get the logged-in user's ID
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .orderBy('created_at', descending: true)
          .get();

      // Convert the fetched documents to a list of Joke objects
      final jokes = snapshot.docs.map((doc) {
        return Joke(
          setup: doc['setup'],
          punchline: doc['punchline'],
        );
      }).toList();

      return jokes;
    } catch (e) {
      print("Error getting favorite jokes: $e");
      return [];
    }
  }
}
