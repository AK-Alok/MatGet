import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ─── Theme Colors ─────────────────────────────────────────────────────────────
class _C {
  static const primary      = Color(0xffff7d3b);
  static const primaryLight = Color(0xFFFFF0EB);
  static const textDark     = Color(0xFF1A1A2E);
  static const textGrey     = Color(0xFF6B7280);
  static const textLight    = Color(0xFF9CA3AF);
  static const divider      = Color(0xFFE5E7EB);
  static const scaffoldBg   = Color(0xFFF5F5F5);
  static const green        = Color(0xFF10B981);
  static const greenBg      = Color(0xFFD1FAE5);
}

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 6 controllers + 6 focus nodes for OTP boxes
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  bool _isVerified = false;

  // ── Resend timer
  int _secondsLeft = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ── Timer ──────────────────────────────────────────────────────────────────
  void _startTimer() {
    _secondsLeft = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  // ── Get full OTP string ────────────────────────────────────────────────────
  String get _otpCode => _controllers.map((c) => c.text).join();

  // ── Verify OTP ─────────────────────────────────────────────────────────────
  Future<void> _verifyOtp() async {
    if (_otpCode.length < 6) {
      _showSnack('Please enter all 6 digits');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpCode,
      );

      await _auth.signInWithCredential(credential);

      setState(() {
        _isLoading = false;
        _isVerified = true;
      });

      await Future.delayed(const Duration(milliseconds: 800));

      // ✅ Navigate to home — replace '/home' with your named route or MainShell
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      if (e.code == 'invalid-verification-code') {
        _showSnack('Incorrect OTP. Please try again.');
        _clearOtp();
      } else if (e.code == 'session-expired') {
        _showSnack('OTP expired. Please request a new one.');
        _clearOtp();
      } else {
        _showSnack(e.message ?? 'Verification failed. Try again.');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnack('Something went wrong. Please try again.');
    }
  }

  void _clearOtp() {
    for (final c in _controllers) c.clear();
    _focusNodes[0].requestFocus();
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
          icon: const Icon(Icons.arrow_back, color: _C.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Icon
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: _C.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.sms_outlined, color: _C.primary, size: 34),
              ),

              const SizedBox(height: 28),

              // ── Title
              const Text(
                'Verify your\nPhone Number',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: _C.textDark,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 10),

              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: _C.textGrey, height: 1.6),
                  children: [
                    const TextSpan(text: 'We sent a 6-digit OTP to\n'),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        color: _C.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // ── OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => _OtpBox(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  isVerified: _isVerified,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      // Move forward
                      if (i < 5) {
                        _focusNodes[i + 1].requestFocus();
                      } else {
                        _focusNodes[i].unfocus();
                        // Auto-verify when last digit entered
                        _verifyOtp();
                      }
                    }
                  },
                  onBackspace: () {
                    // Move back on delete
                    if (i > 0 && _controllers[i].text.isEmpty) {
                      _focusNodes[i - 1].requestFocus();
                    }
                  },
                )),
              ),

              const SizedBox(height: 28),

              // ── Resend Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the OTP? ",
                    style: TextStyle(fontSize: 13, color: _C.textGrey),
                  ),
                  _secondsLeft > 0
                      ? Text(
                          'Resend in ${_secondsLeft}s',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _C.textLight,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _clearOtp();
                            _startTimer();
                            Navigator.pop(context); // go back to re-enter phone
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _C.primary,
                            ),
                          ),
                        ),
                ],
              ),

              const SizedBox(height: 40),

              // ── Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_isLoading || _isVerified) ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isVerified ? _C.green : _C.primary,
                    disabledBackgroundColor:
                        _isVerified ? _C.green : _C.primary.withOpacity(0.6),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
                      : _isVerified
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Verified!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Verify OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Change number
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Change Phone Number',
                    style: TextStyle(
                      fontSize: 13,
                      color: _C.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── OTP Single Box ───────────────────────────────────────────────────────────

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isVerified;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.isVerified,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 56,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            onBackspace();
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isVerified ? _C.green : _C.textDark,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: isVerified
                ? _C.greenBg
                : focusNode.hasFocus
                    ? _C.primaryLight
                    : Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: controller.text.isNotEmpty ? _C.primary : _C.divider,
                width: controller.text.isNotEmpty ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _C.primary, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}