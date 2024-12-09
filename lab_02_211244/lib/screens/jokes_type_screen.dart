import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../widgets/joke_card.dart';
import 'jokes_list_screen.dart';
import 'random_joke_screen.dart';

class JokesTypeScreen extends StatelessWidget {
  final JokeService jokeService = JokeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        backgroundColor: Colors.yellow[100], // App bar color
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/originals/3f/35/fa/3f35fac58640593b47b4d5654c8203f2.jpg', // Laughing emoji image URL
            ),
            fit: BoxFit.cover,
            opacity: 0.9, // Slightly transparent background
          ),
        ),
        child: FutureBuilder<List<String>>(
          future: jokeService.getJokeTypes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load joke types'));
            } else {
              final jokeTypes = snapshot.data!;
              return ListView.builder(
                itemCount: jokeTypes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.yellow[100], 
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: JokeCard(
                        jokeType: jokeTypes[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JokesListScreen(type: jokeTypes[index]),
                            ),
                          );
                        },
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