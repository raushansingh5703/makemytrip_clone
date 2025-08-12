import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../services/user_preferences.dart';
import '../../utils/validators.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool emailVerified = false;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;

  final List<String> slideTexts = [
    "Reset your password securely in just a few steps",
    "We’ll first verify your registered email",
    "Then you can set a new password instantly"
  ];
  int _currentSlide = 0;

  /// Step 1: Verify Email
  Future<void> verifyEmail() async {
    if (!_formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    bool exists = await AuthService.isEmailRegistered(email);

    if (exists) {
      setState(() {
        emailVerified = true;
      });
      _showMessage("Email verified! Please enter your new password", true);
    } else {
      _showMessage("Email not found", false);
    }
  }

  /// Step 2: Reset Password
  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      _showMessage("Passwords do not match", false);
      return;
    }

    final result = await AuthService.resetPassword(email, newPassword);
    _showMessage(result["message"], result["success"]);

    if (result["success"]) {
      Navigator.pop(context);
    }
  }

  void _showMessage(String msg, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // allows view to adjust for keyboard
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1521791136064-7986c2920216"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Carousel
                  CarouselSlider(
                    items: slideTexts
                        .map((text) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 20,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            )
                          ],
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ))
                        .toList(),
                    options: CarouselOptions(
                      height: 90,
                      autoPlay: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentSlide = index;
                        });
                      },
                    ),
                  ),

                  // Dots Indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        slideTexts.length,
                            (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentSlide == index
                                ? Colors.white
                                : Colors.white54,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Ticket Widget Form
                  TicketWidget(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: emailVerified ? 400 : 250,
                    isCornerRounded: true,
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),

                          // Email field
                          CustomTextField(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            controller: emailController,
                            labelText: 'Email',
                            hintText: 'Enter your registered email',
                            validator: Validators.validateEmail,
                            prefixIcon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 30),

                          if (emailVerified) ...[
                            CustomTextField(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              controller: newPasswordController,
                              labelText: 'New Password',
                              hintText: 'Enter new password',
                              obscureText: !_passwordVisible1,
                              onToggleVisibility: () {
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                });
                              },
                              validator: Validators.validatePassword,
                              prefixIcon: Icons.lock_outline,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              controller: confirmPasswordController,
                              labelText: 'Confirm Password',
                              hintText: 'Re-enter password',
                              obscureText: !_passwordVisible2,
                              onToggleVisibility: () {
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              prefixIcon: Icons.lock_outline,
                            ),
                            const SizedBox(height: 20),
                          ],

                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed:
                              emailVerified ? resetPassword : verifyEmail,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2575FC),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                emailVerified
                                    ? "UPDATE PASSWORD"
                                    : "VERIFY EMAIL",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
