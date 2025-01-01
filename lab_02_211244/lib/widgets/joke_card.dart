import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String jokeType;
  final Color? color;
  final VoidCallback onTap;

  const JokeCard({super.key, required this.jokeType, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color, // Apply the passed color here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jokeType,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
