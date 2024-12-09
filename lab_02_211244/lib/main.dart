import 'package:flutter/material.dart';
import 'package:lab_02_211244/screens/jokes_type_screen.dart'; // Import the home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke Types',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokesTypeScreen(),
    );
  }
}
