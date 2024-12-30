import 'package:flutter/material.dart';
import 'package:lab_02_211244/screens/jokes_type_screen.dart'; // Import the home screen
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
