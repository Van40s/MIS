import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../models/jokes.dart';
import '../services/firebase_service.dart';

class JokesListScreen extends StatefulWidget {
  final String type;
  JokesListScreen({super.key, required this.type});

  @override
  _JokesListScreenState createState() => _JokesListScreenState();
}

class _JokesListScreenState extends State<JokesListScreen> {
  final JokeService jokeService = JokeService();
  final FirebaseService firebaseService = FirebaseService();
  Set<int> favoritedJokes = {}; // To track the favorited jokes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Jokes'),
        backgroundColor: Colors.yellow[100],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/originals/3f/35/fa/3f35fac58640593b47b4d5654c8203f2.jpg', // Background image URL
            ),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: FutureBuilder<List<Joke>>(
          future: jokeService.getJokesByType(widget.type),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load jokes'));
            } else {
              final jokes = snapshot.data!;
              return ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  final isFavorited = favoritedJokes.contains(index);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.yellow[100],
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
                            IconButton(
                              icon: Icon(
                                isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorited ? Colors.red : Colors.grey,
                              ),
                              onPressed: () async {
                                await firebaseService.saveFavoriteJoke(joke);
                                setState(() {
                                  if (isFavorited) {
                                    favoritedJokes.remove(index);
                                  } else {
                                    favoritedJokes.add(index);
                                  }
                                });
                              },
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
