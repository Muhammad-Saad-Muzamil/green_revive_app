import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:greenreviveapp/pages/auth_pages/login_page.dart';

import 'package:greenreviveapp/pages/home_page/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:AuthWrapper(),
    );
  }
}
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use FirebaseAuth to check if user is signed in
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // If no user is signed in, show the Login screen
      return LoginScreen();
    } else {
      // If a user is signed in, show the Home screen
      return const HomePage();}}}

 