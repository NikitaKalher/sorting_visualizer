import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Navigate to the home screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/home'); // Navigate to the home screen
    });
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the SplashController
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedText(),
        ),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation

    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth up and down movement
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value), // Move text up and down
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Semi-transparent background
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), // Padding for the text
            child: Text(
              "SORTING VISUALIZER",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              textAlign: TextAlign.center, // Center the text
            ),
          ),
        );
      },
    );
  }
}
