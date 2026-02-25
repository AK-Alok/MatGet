import 'package:flutter/material.dart';
import 'dart:async';

import 'package:matget/screens/getstarted_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;

  late AnimationController _matGetController;
  late Animation<double> _matgetOpacity;
  late Animation<Offset> _matgetSlide;

  late AnimationController _taglineController;
  late Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    // LOGO BOUNCE ANIMATION
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _logoScale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.2).chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 40,
      ),
    ]).animate(_logoController);

    _logoOpacity = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(_logoController);

    // MATGET TEXT ANIMATION
    _matGetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _matgetOpacity = Tween(begin: 0.0, end: 1.0).animate(_matGetController);
    _matgetSlide = Tween<Offset>(begin: Offset(0, 0.4), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _matGetController, curve: Curves.easeOut));

    // TAGLINE ANIMATION
    _taglineController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    _taglineOpacity = Tween(begin: 0.0, end: 1.0).animate(_taglineController);

    // PLAY ANIMATIONS IN SEQUENCE
    _logoController.forward().then((_) {
      _matGetController.forward().then((_) {
        _taglineController.forward();
      });
    });

    // NAVIGATE TO NEXT PAGE
    Timer(Duration(seconds: 3), () {
      // Replace with your next screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GetStartedScreen()));
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _matGetController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGO WITH BOUNCE ANIMATION
            FadeTransition(
              opacity: _logoOpacity,
              child: ScaleTransition(
                scale: _logoScale,
                child: Image.asset(
                  "assets/logos/matgetlogo.png",
                  height: 210,
                ),
              ),
            ),

            SizedBox(height: 0),

            // MATGET TEXT
            FadeTransition(
              opacity: _matgetOpacity,
              child: SlideTransition(
                position: _matgetSlide,
                child: Transform.translate(
                  offset: Offset(0, -50),
                  child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Mat",
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFF57C00), // Orange
                        ),
                      ),
                      TextSpan(
                        text: "Get",
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF424242), // Dark Grey
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ),
            ),

            // TAGLINE
            FadeTransition(
              opacity: _taglineOpacity,
              child: Transform.translate(
                offset: Offset(0, -45),
              child: Text(
                "Where Quality meets Affordability",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
