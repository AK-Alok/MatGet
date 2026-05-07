import 'package:flutter/material.dart';
import 'package:matget/controllers/auth_controller.dart';
import 'package:matget/screens/login_screen.dart';
import 'package:matget/screens/main_shell.dart';
import 'getstarted_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agreeTerms = false;
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
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
              offset: Offset(0, -28),
              child: const Text(
                "Create Account",
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
              offset: Offset(0, -22),
              child: const Text(
                "Let's get you set up.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 5),

            // --------------------------
            // FULL NAME
            // --------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Container(
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
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // --------------------------
            // Email
            // --------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email Address",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Container(
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
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                  hintText: "Enter your email address",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // --------------------------
            // PASSWORD
            // --------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Container(
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
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  hintText: "Create your password",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // --------------------------
            // TERMS CHECKBOX
            // --------------------------
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: agreeTerms,
                    activeColor: Color(0xFFE8541A),
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),

                      children: [
                        const TextSpan(text: "I agree to the "),

                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,

                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(28),
                                  ),
                                ),

                                builder: (context) {
                                  return DraggableScrollableSheet(
                                    expand: false,
                                    initialChildSize: 0.85,
                                    minChildSize: 0.5,
                                    maxChildSize: 0.95,

                                    builder: (_, controller) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 18,
                                        ),

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            // TOP BAR
                                            Center(
                                              child: Container(
                                                width: 50,
                                                height: 5,

                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 22),

                                            // TITLE
                                            const Text(
                                              "Terms & Conditions",

                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff1a2238),
                                              ),
                                            ),

                                            const SizedBox(height: 8),

                                            const Text(
                                              "Please read and accept before creating your account.",

                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),

                                            const SizedBox(height: 24),

                                            // CONTENT
                                            Expanded(
                                              child: SingleChildScrollView(
                                                controller: controller,

                                                child: const Text(
                                                  '''
1. Account Information
Users must provide accurate and complete registration details while creating an account on MatGet.

2. Platform Usage
MatGet is designed for purchasing construction and building materials including cement, bricks, steel rods, sand, gravel, paint, pipes, tools, and related products.

3. Orders & Pricing
Product prices, stock availability, delivery charges, and offers may change without prior notice.

4. Payment Terms
Payments must be completed using approved payment methods available within the application.

5. Delivery & Logistics
Delivery timelines are estimated and may vary depending on supplier availability, traffic conditions, weather, or operational limitations.

6. User Responsibility
Users are responsible for checking product quantity, specifications, pricing, and delivery address before placing an order.

7. Privacy & Security
Your personal information is securely stored and used only for authentication, order processing, support services, and improving user experience.

8. Restricted Activities
Fraudulent activity, misuse of the platform, fake orders, or abusive behavior may result in suspension or permanent termination of the account.

9. Updates to Terms
MatGet reserves the right to update or modify these Terms & Conditions at any time without prior notice.

10. Acceptance
By creating an account and continuing to use MatGet, you acknowledge and accept all Terms & Conditions stated above.
''',

                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    height: 1.7,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(height: 18),

                                            // BUTTON
                                            SizedBox(
                                              width: double.infinity,

                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },

                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xffff7d3b,
                                                  ),

                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 16,
                                                      ),

                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          14,
                                                        ),
                                                  ),
                                                ),

                                                child: const Text(
                                                  "I Understand",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },

                            child: const Text(
                              "Terms and Conditions",

                              style: TextStyle(
                                color: Color(0xFFE8541A),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --------------------------
            // CREATE ACCOUNT BUTTON
            // --------------------------
            PressableButton(
              onTap: () async {
                if (!agreeTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Accept terms first")),
                  );
                  return;
                }

                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter valid details")),
                  );
                  return;
                }

                setState(() => isLoading = true);

                final success = await _authController.signUpWithEmail(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );

                setState(() => isLoading = false);

                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MainShell()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Signup failed")),
                  );
                }
              },
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xffff7d3b),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isLoading ? "Creating..." : "Create Account",
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

            // --------------------------
            // LOGIN TEXT
            // --------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(width: 5),
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE8541A),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
