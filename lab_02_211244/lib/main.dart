import 'package:flutter/material.dart';
import 'package:lab_02_211244/models/jokes.dart';
import 'package:lab_02_211244/screens/jokes_type_screen.dart';
import 'package:lab_02_211244/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:lab_02_211244/services/auth_service.dart';
import 'package:lab_02_211244/providers/password_visibility_provider.dart';
import 'package:lab_02_211244/providers/joke_provider.dart';
import 'package:lab_02_211244/screens/favorites_jokes_screen.dart';
import 'package:lab_02_211244/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
    print("Environment file loaded successfully: ${dotenv.env}");
  } catch (e) {
    print("Error loading environment file: $e");
  }

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide AuthService for authentication across the app
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        // Provide PasswordVisibilityProvider for managing password visibility state
        ChangeNotifierProvider<PasswordVisibilityProvider>(
          create: (_) => PasswordVisibilityProvider(),
        ),
        // Provide JokeProvider for managing joke-related data
        ChangeNotifierProvider<JokeProvider>(
          create: (_) => JokeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Joke Types',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Set the initial route to LoginPage
        home: const LoginPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home), label: 'Jokes'),
          NavigationDestination(
            icon: FutureBuilder<List<Joke>>(
              future: firebaseService.getFavoriteJokes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Icon(Icons.favorite_border);
                }

                if (snapshot.hasError) {
                  return Icon(Icons.error);
                }

                final favoriteJokes = snapshot.data ?? [];
                final jokeCount = favoriteJokes.length;

                return Badge(
                  label: Text(jokeCount.toString()), // Display dynamic count
                  child: const Icon(Icons.favorite),
                );
              },
            ),
            label: 'Favorites',
          ),
        ],
        selectedIndex: currentPageIndex,
      ),
      body: [
        JokesTypeScreen(), // Update with your jokes screen
        FavoriteJokesScreen(),
      ][currentPageIndex],
    );
  }
}
