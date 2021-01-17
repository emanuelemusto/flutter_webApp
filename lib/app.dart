import 'package:flutter/material.dart';
import 'package:flutter_webapp/constants.dart';
import 'Screens/Welcome/welcome_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medici App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white
      ),
      home: WelcomeScreen(),
    );
  }
}
