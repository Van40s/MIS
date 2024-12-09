import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../models/jokes.dart';

class JokesListScreen extends StatelessWidget {
  final String type;
  final JokeService jokeService = JokeService();

  JokesListScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Jokes'),
        backgroundColor: Colors.yellow[100], // App bar background color matching the card color
        iconTheme: IconThemeData(color: Colors.black), // Set app bar icons to black
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/originals/3f/35/fa/3f35fac58640593b47b4d5654c8203f2.jpg', // Replace with your image URL
            ),
            fit: BoxFit.cover,
            opacity: 0.9, // Slightly transparent so the text is readable
          ),
        ),
        child: FutureBuilder<List<Joke>>(
          future: jokeService.getJokesByType(type),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load jokes'));
            } else {
              final jokes = snapshot.data!;
              return ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.yellow[100], // Light yellow background for the card
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              joke.setup,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              joke.punchline,
                              style: TextStyle(
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
