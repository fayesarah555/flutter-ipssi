import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'Pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Example',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Dark theme for a more futuristic look
        scaffoldBackgroundColor: Colors.black, // Matches the futuristic style
      ),
      home: const FirebaseInitScreen(), // Loading screen during Firebase initialization
    );
  }
}

class FirebaseInitScreen extends StatefulWidget {
  const FirebaseInitScreen({Key? key}) : super(key: key);

  @override
  _FirebaseInitScreenState createState() => _FirebaseInitScreenState();
}

class _FirebaseInitScreenState extends State<FirebaseInitScreen> {
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  // Initialize Firebase and set state accordingly
  void _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Scaffold(
        body: Center(
          child: Text(
            'Failed to initialize Firebase',
            style: TextStyle(color: Colors.redAccent, fontSize: 18),
          ),
        ),
      );
    }

    if (!_initialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.cyanAccent,
          ), // Loading indicator
        ),
      );
    }

    // Once Firebase is initialized, go to HomePage
    return const HomePage();
  }
}
