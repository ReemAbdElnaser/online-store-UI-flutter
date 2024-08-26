import 'package:flutter/material.dart';
import 'dart:async';
import 'onbording.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController and Animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    fadingAnimation = Tween<double>(begin: 0.2, end: 1).animate(animationController!);

    // Repeat the animation
    animationController?.repeat(reverse: true);

    // Navigate to the OnboardingScreen after a delay
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the AnimationController
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Adjust the space above the title
            const SizedBox(height: 100), // Adjust this value to move text up or down
            // Use AnimatedBuilder or FadeTransition to apply the animation
            AnimatedBuilder(
              animation: fadingAnimation!,
              builder: (context, child) {
                return Opacity(
                  opacity: fadingAnimation!.value,
                  child: child,
                );
              },
              child: const Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 5, 5),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between the title and subtitle
            const Center(
              child: Text(
                'Welcome to the biggest online store',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 30, 33, 30),
                ),
              ),
            ),
            const SizedBox(height: 50), // Medium space between subtitle and image
            Image.asset('assets/n.png', width: 300, height: 300), // Adjusted size for better fit
          ],
        ),
      ),
    );
  }
}
