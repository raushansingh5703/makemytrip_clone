import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:makemytrip_clone/utils/validators.dart';
import 'package:makemytrip_clone/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/user_preferences.dart';
import '../dashboard/dashboard_screen.dart';
import 'forgot_password_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  final List<String> slideTexts = [
    "Upto 30% OFF on your first booking as a Welcome Gift",
    "Join the club of 10 crore+ happy travellers",
    "Book your 1st International trip on Makemytrip"
  ];

  int _currentSlide = 0;

  void _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final result = await AuthService.loginOrSignup(email, password);

    _showSnackBar(result["message"], result["success"]);

    if (result["success"]) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      });
    }
  }

  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure keyboard pushes content
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1506744038136-46273834b3fb"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            height: double.infinity,
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

          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120),

                // Slider + Indicators
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: slideTexts
                          .map((text) => Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
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
                          textAlign: TextAlign.start, // aligned left
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

                    // Dots Indicator aligned left
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          slideTexts.length,
                              (index) => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 4),
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
                  ],
                ),

                const SizedBox(height: 20),

                // Ticket Widget
                TicketWidget(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 420,
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Signup or Login",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),

                        CustomTextField(
                          border: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          validator: Validators.validateEmail,
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          border: const OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          obscureText: !_passwordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          validator: Validators.validatePassword,
                          prefixIcon: Icons.lock_outline,
                        ),

                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _handleAuth,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2575FC),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              "CONFIRM",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("OR"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.g_mobiledata,
                                  size: 40, color: Colors.red),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.email_outlined,
                                  size: 28, color: Colors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical:9 ),
                  child: Text(
                    "By proceeding, you agree to MakeMyTrip's Privacy Policy, User Agreement, and T&Cs. as well as Mobile Contact's T&Cs",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 10, color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
