import 'package:flutter/material.dart';
import 'package:matget/screens/home_screen.dart';
import 'package:matget/screens/getstarted_screen.dart';

bool rememberMe = false;

class MatGetLogin extends StatelessWidget {
  const MatGetLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LOGO
              SizedBox(
                height: 140,
                child: Image.asset(
                  "assets/logos/matgetlogo.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 0),

              // Title
              Transform.translate(
                offset: Offset(0, -28), // move upward to reduce gap
                child: const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1a2238),
                  ),
                ),
              ),

              const SizedBox(height: 0),

              // Subtitle
              Transform.translate(
                offset: Offset(0, -25),
                child: const Text(
                  "Log in to continue your journey.",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 5),
              // Email Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: BoxBorder.all(color: Colors.grey[400]!, width: 1),
                ),
                child: const TextField(
                  // textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email_rounded, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 13),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Password Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: BoxBorder.all(color: Colors.grey[400]!, width: 1),
                ),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),

                    contentPadding: EdgeInsets.symmetric(vertical: 13),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              // Remember Me
              Transform.translate(
                offset: Offset(-10, -4),
                child: Row(
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            value: rememberMe,
                            activeColor: Color(0xffff7d3b),
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 0),

                    const Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Forgot Password
              Transform.translate(
                offset: Offset(0, -20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xffff7d3b),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // Login Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color(0xffff7d3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or log in with"),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                ],
              ),

              const SizedBox(height: 25),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialButton("assets/icons/google.png"),
                  _socialButton("assets/icons/apple.png"),
                  _socialButton("assets/icons/facebook.png"),
                ],
              ),

              const SizedBox(height: 28),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => GetStartedScreen()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xffff7d3b),
                        fontWeight: FontWeight.w700,
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
    );
  }

  Widget _socialButton(String iconPath) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(child: Image.asset(iconPath, width: 28)),
    );
  }
}
