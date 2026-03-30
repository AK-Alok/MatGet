import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matget/screens/phone_authentication.dart';
import 'package:matget/screens/main_shell.dart'; 
import 'package:matget/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ← Firebase init
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatGet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        useMaterial3: true,
      ),

      // ── Starting screen ──────────────────────────
      initialRoute: '/splash',   // ← app opens here

      // ── All named routes ─────────────────────────
      routes: {
        '/splash': (_) => const SplashScreen(),  // ← optional splash screen
        '/login': (_) => const PhoneAuthScreen(),  // ← OTP login
        '/home':  (_) => const MainShell(),        // ← after login
      },
    );
  }
}