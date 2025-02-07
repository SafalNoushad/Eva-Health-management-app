import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sanguard/screens/terms_and_conditions_screen.dart';
import 'package:sanguard/utils/custom_painters.dart'; // Ensure this file contains FlowerPainter and HeartPainter
import 'dart:math' as math;

class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  _StartupScreenState createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  final List<Widget> _animatedShapes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateRandomShapes(context);
    });
  }

  void _generateRandomShapes(BuildContext context) {
    final random = math.Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    for (int i = 0; i < 10; i++) {
      final isFlower = random.nextBool();
      final color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        0.6,
      );
      final size = random.nextDouble() * 30 + 20;
      final left = random.nextDouble() * screenWidth;
      final top = random.nextDouble() * screenHeight;

      _animatedShapes.add(
        Positioned(
          left: left,
          top: top,
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: isFlower ? FlowerPainter(color) : HeartPainter(color),
            ),
          )
              .animate()
              .moveY(
                duration: Duration(seconds: random.nextInt(5) + 5),
                begin: 0,
                end: 100,
                curve: Curves.easeInOut,
              )
              .scale(
                duration: Duration(seconds: random.nextInt(3) + 2),
                alignment: Alignment.center, // Ensures scaling from the center
                curve: Curves.easeInOut,
                begin: const Offset(0.8, 0.8), // Scale to 80%
                end: const Offset(1.2, 1.2), // Scale to 120%
              ),
        ),
      );
    }
    setState(() {}); // Trigger rebuild to display shapes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._animatedShapes,
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Welcome to Eva',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ).animate().fadeIn(duration: const Duration(seconds: 1)),
                const SizedBox(height: 10),
                Text(
                  'Your Menstrual Health Companion',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ).animate().fadeIn(
                      duration: const Duration(seconds: 1),
                      delay: const Duration(milliseconds: 500),
                    ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const TermsAndConditionsScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0), // Start off-screen
                              end: Offset.zero, // End at the current position
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Get Started'),
                ).animate().fadeIn(
                      duration: const Duration(seconds: 1),
                      delay: const Duration(seconds: 1),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
