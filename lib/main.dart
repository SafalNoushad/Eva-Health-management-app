import 'package:flutter/material.dart';
import 'package:sanguard/screens/startup_screen.dart';

void main() {
  runApp(const MenstrualHealthApp());
}

class MenstrualHealthApp extends StatelessWidget {
  const MenstrualHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eva',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 255, 255, 255), // Mild background color
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 2, 2, 2),
          secondary: const Color.fromARGB(255, 146, 153, 201),
          surface: const Color.fromARGB(255, 156, 159, 208),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0)),
          displayMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0)),
          bodyLarge:
              TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
          labelLarge:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 230, 219, 233),
            foregroundColor: Color.fromARGB(255, 148, 114, 193),
          ),
        ),
      ),
      home: const StartupScreen(),
    );
  }
}
