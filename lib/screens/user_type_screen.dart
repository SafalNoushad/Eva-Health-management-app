import 'package:flutter/material.dart';
import 'package:sanguard/screens/birth_year_screen.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you using this app for yourself or for a partner?",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 40),
              _buildOptionButton(context, 'For Myself', Icons.person),
              const SizedBox(height: 20),
              _buildOptionButton(context, 'For a Partner', Icons.people),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String text, IconData icon) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const BirthYearScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
