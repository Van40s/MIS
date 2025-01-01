import 'package:flutter/material.dart';
import '../models/jokes.dart';
import '../services/firebase_service.dart';

class FavoriteJokesScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  FavoriteJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.yellow[100], // App bar background color matching the card color
        iconTheme: const IconThemeData(color: Colors.black), // Set app bar icons to black
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/originals/3f/35/fa/3f35fac58640593b47b4d5654c8203f2.jpg', // Background image URL
            ),
            fit: BoxFit.cover,
            opacity: 0.9, // Slightly transparent so the text is readable
          ),
        ),
        child: FutureBuilder<List<Joke>>(
          future: firebaseService.getFavoriteJokes(), // Fetch favorite jokes from Firebase
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load favorite jokes'));
            } else {
              final jokes = snapshot.data ?? [];
              return ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.yellow[100], // Light yellow background for the card
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              joke.setup,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              joke.punchline,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
