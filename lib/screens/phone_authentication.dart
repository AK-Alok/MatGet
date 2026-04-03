import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matget/screens/otp_screen.dart';
import 'package:matget/screens/getstarted_screen.dart';

// ─── Theme Colors ─────────────────────────────────────────────────────────────
class _C {
  static const primary = Color(0xffff7d3b);
  //static const primaryLight = Color(0xFFFFF0EB);
  static const textDark = Color(0xFF1A1A2E);
  static const textGrey = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const divider = Color(0xFFE5E7EB);
  static const scaffoldBg = Color(0xFFF5F5F5);
}

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _selectedCountryCode = '+91';

  final List<Map<String, String>> _countryCodes = const [
    {'code': '+91', 'flag': '🇮🇳', 'name': 'India'},
    {'code': '+1', 'flag': '🇺🇸', 'name': 'USA'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'UK'},
    {'code': '+61', 'flag': '🇦🇺', 'name': 'Australia'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'UAE'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // ── Send OTP ───────────────────────────────────────────────────────────────
  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      _showSnack('Please enter a valid mobile number');
      return;
    }

    setState(() => _isLoading = true);

    final fullNumber = '$_selectedCountryCode$phone';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullNumber,
        timeout: const Duration(seconds: 60),

        // OTP sent — navigate to OTP screen
        codeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                phoneNumber: fullNumber,
                verificationId: verificationId,
              ),
            ),
          );
        },

        // Auto-verified on Android
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          setState(() => _isLoading = false);
          // Navigate to home — replace with your MainShell route
          Navigator.pushReplacementNamed(context, '/home');
        },

        // Error
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          _showSnack(e.message ?? 'Verification failed. Try again.');
        },

        // Timeout
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() => _isLoading = false);
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnack('Something went wrong. Please try again.');
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: _C.textDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.scaffoldBg,
      appBar: AppBar(
        backgroundColor: _C.scaffoldBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 18, 18, 57)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => GetStartedScreen()
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // ── Logo / Icon
              SizedBox(
                height: 120,
                child: Image.asset(
                  "assets/logos/matgetlogo.png",
                  fit: BoxFit.contain,
                ),
              ),

              //const SizedBox(height: 28),

              // ── Title
              Transform.translate(
                offset: Offset(0, -12),
                child: const Text(
                  'Enter your\nPhone Number',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: _C.textDark,
                    height: 1.25,
                  ),
                ),
              ),

              //const SizedBox(height: 10),
              const Text(
                'We\'ll send you a verification code to \nconfirm your number.',
                style: TextStyle(fontSize: 14, color: _C.textGrey, height: 1.6),
              ),

              const SizedBox(height: 30),

              // ── Phone Input Label
              const Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _C.textDark,
                ),
              ),

              const SizedBox(height: 8),

              // ── Phone Input Row
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _C.divider),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Country code picker
                    GestureDetector(
                      onTap: _showCountryPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(right: BorderSide(color: _C.divider)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _countryCodes.firstWhere(
                                (c) => c['code'] == _selectedCountryCode,
                              )['flag']!,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _selectedCountryCode,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: _C.textDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: _C.textGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Phone number field
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _C.textDark,
                          letterSpacing: 1.5,
                        ),
                        decoration: const InputDecoration(
                          hintText: '00000 00000',
                          hintStyle: TextStyle(
                            color: _C.textLight,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ── Note
              Row(
                children: const [
                  Icon(Icons.lock_outline, size: 13, color: _C.textLight),
                  SizedBox(width: 5),
                  Text(
                    'Your number is safe and will never be shared.',
                    style: TextStyle(fontSize: 12, color: _C.textLight),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ── Send OTP Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _C.primary,
                    disabledBackgroundColor: _C.primary.withOpacity(0.6),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Send OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Terms
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontSize: 12, color: _C.textGrey),
                    children: [
                      TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: _C.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: _C.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Country Picker Bottom Sheet ────────────────────────────────────────────
  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Country',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _C.textDark,
              ),
            ),
            const SizedBox(height: 16),
            ..._countryCodes.map(
              (c) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(c['flag']!, style: const TextStyle(fontSize: 24)),
                title: Text(
                  c['name']!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: _C.textDark,
                  ),
                ),
                trailing: Text(
                  c['code']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _C.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  setState(() => _selectedCountryCode = c['code']!);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
