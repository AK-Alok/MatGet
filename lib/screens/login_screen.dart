import 'package:flutter/material.dart';
import 'package:matget/controllers/auth_controller.dart';
import 'package:matget/screens/getstarted_screen.dart';
import 'package:matget/screens/main_shell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MatGetLogin extends StatefulWidget {
  const MatGetLogin({super.key});

  @override
  State<MatGetLogin> createState() => _MatGetLoginState();
}

class _MatGetLoginState extends State<MatGetLogin> {
  bool rememberMe = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final AuthController _authController = AuthController();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google Sign-In Failed")));

      print(e);
    }
  }

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

              Transform.translate(
                offset: const Offset(0, -28),
                child: const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1a2238),
                  ),
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -25),
                child: const Text(
                  "Log in to continue your journey.",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 12),

              // EMAIL LABEL
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Email Address",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 5),

              // EMAIL FIELD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),

                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ],

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(color: Colors.grey.shade400),
                ),

                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: const InputDecoration(
                    border: InputBorder.none,

                    prefixIcon: Icon(Icons.email_rounded, color: Colors.grey),

                    contentPadding: EdgeInsets.symmetric(vertical: 13),

                    hintText: "Enter your email",
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // PASSWORD LABEL
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 5),

              // PASSWORD FIELD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),

                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ],

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(color: Colors.grey.shade400),
                ),

                child: TextField(
                  controller: passwordController,
                  obscureText: true,

                  decoration: const InputDecoration(
                    border: InputBorder.none,

                    prefixIcon: Icon(Icons.lock, color: Colors.grey),

                    contentPadding: EdgeInsets.symmetric(vertical: 13),

                    hintText: "Enter your password",
                  ),
                ),
              ),

              // REMEMBER ME
              Transform.translate(
                offset: const Offset(-10, -4),

                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.8,

                      child: Checkbox(
                        value: rememberMe,

                        activeColor: const Color(0xffff7d3b),

                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                    ),

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

              // FORGOT PASSWORD
              Transform.translate(
                offset: const Offset(0, -20),

                child: Align(
                  alignment: Alignment.centerRight,

                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,

                        builder: (context) {
                          final TextEditingController resetController =
                              TextEditingController();

                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),

                            title: const Text("Reset Password"),

                            content: TextField(
                              controller: resetController,

                              keyboardType: TextInputType.emailAddress,

                              decoration: const InputDecoration(
                                hintText: "Enter your email",
                              ),
                            ),

                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },

                                child: const Text("Cancel"),
                              ),

                              ElevatedButton(
                                onPressed: () async {
                                  final email = resetController.text.trim();

                                  if (email.isEmpty) return;

                                  final success = await _authController
                                      .resetPassword(email);

                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        success
                                            ? "Password reset email sent"
                                            : "Failed to send reset email",
                                      ),
                                    ),
                                  );
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffff7d3b),
                                ),

                                child: const Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },

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

              // LOGIN BUTTON
              GestureDetector(
                onTap: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter email & password")),
                    );

                    return;
                  }

                  setState(() => isLoading = true);

                  final success = await _authController.loginWithEmail(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  setState(() => isLoading = false);

                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainShell()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid credentials")),
                    );
                  }
                },

                child: Container(
                  width: 200,

                  padding: const EdgeInsets.symmetric(vertical: 15),

                  decoration: BoxDecoration(
                    color: const Color(0xffff7d3b),

                    borderRadius: BorderRadius.circular(14),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),

                  child: Center(
                    child: Text(
                      isLoading ? "Logging in..." : "Log In",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // DIVIDER
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

              // SOCIAL BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  GestureDetector(
                    onTap: signInWithGoogle,
                    child: _socialButton("assets/icons/google.png"),
                  ),

                  _socialButton("assets/icons/apple.png"),

                  _socialButton("assets/icons/facebook.png"),
                ],
              ),

              const SizedBox(height: 28),

              // SIGNUP
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

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: Colors.grey),
      ),

      child: Center(child: Image.asset(iconPath, width: 28)),
    );
  }
}
