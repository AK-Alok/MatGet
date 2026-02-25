import 'package:flutter/material.dart';
import 'package:matget/screens/login_screen.dart';
import 'package:matget/screens/signup_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(height: 0),

                // LOGO
                Transform.translate(
                  offset: Offset(0, -28),
                  child: SizedBox(
                    height: 150,
                    child: Image.asset("assets/logos/matgetlogo.png"),
                  ),
                ),

                const SizedBox(height: 0),
                Transform.translate(
                  offset: Offset(0, -55),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1a2238),
                    ),
                  ),
                ),

                const SizedBox(height: 0),

                Transform.translate(
                  offset: Offset(0, -45),
                  child: const Text(
                    "Choose your preferred sign up\nmethod.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 0),

                // ---------- GOOGLE BUTTON ----------
                SizedBox(
                  width: 300,
                  child: PressableButton(
                    onTap: () {
                      print("Google Sign Up");
                    },
                    child: _socialButton(
                      icon: "assets/icons/google.png",
                      text: "Sign Up with Google",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---------- APPLE BUTTON ----------
                SizedBox(
                  width: 300,
                  child: PressableButton(
                    onTap: () {
                      print("Apple Sign Up");
                    },
                    child: _socialButton(
                      icon: "assets/icons/apple.png",
                      text: "Sign Up with Apple",
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // ---------- MOBILE BUTTON ----------
                PressableButton(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()),
                    );
                  },
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xffff7d3b),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up with Mobile No.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MatGetLogin()),
                        );
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffff7d3b),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Social button reuse widget
  Widget _socialButton({required String icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xff1a2238),
            ),
          ),
        ],
      ),
    );
  }
}

//
// -------- BUTTON PRESS ANIMATION --------
//
class PressableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const PressableButton({required this.child, required this.onTap, super.key});

  @override
  State<PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton> {
  double _scale = 1.0;

  void _down(TapDownDetails d) => setState(() => _scale = 0.95);
  void _up(TapUpDetails d) => setState(() => _scale = 1.0);
  void _cancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: _cancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: widget.child,
      ),
    );
  }
}
