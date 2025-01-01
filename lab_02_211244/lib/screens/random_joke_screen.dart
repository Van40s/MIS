import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../models/jokes.dart';

class RandomJokeScreen extends StatelessWidget {
  final JokeService jokeService = JokeService();

  RandomJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke of the Day'),
        backgroundColor: Colors.yellow[100], // Set AppBar color here
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/originals/3f/35/fa/3f35fac58640593b47b4d5654c8203f2.jpg', // Laughing emoji image URL
            ),
            fit: BoxFit.cover,
            opacity: 0.9, // Slightly transparent background
          ),
        ),
        child: FutureBuilder<Joke>(
          future: jokeService.getRandomJoke(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load random joke'));
            } else {
              final joke = snapshot.data!;
              return Center(
                child: Card(
                  color: Colors.yellow[100], // Set Card color here
                  elevation: 5.0, // Add elevation for card shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          joke.setup,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          joke.punchline,
                          style: const TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
