import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Color _topColor = Colors.teal.shade700;
  Color _bottomColor = Colors.teal.shade300;

  @override
  void initState() {
    super.initState();
    _startGradientAnimation();
  }

  void _startGradientAnimation() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        // Toggle between two different gradient colors
        _topColor = _topColor == Colors.teal.shade700
            ? Colors.teal.shade900
            : Colors.teal.shade700;
        _bottomColor = _bottomColor == Colors.teal.shade300
            ? Colors.teal.shade600
            : Colors.teal.shade300;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_topColor, _bottomColor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),

            // Animated logo with scaling effect
            AnimatedScale(
              scale: 1.2,
              duration: Duration(seconds: 1),
              child: Image.asset(
                'lib/assets/5.png', // Replace with your logo path
                height: 120,
                width: 120,
              ),
            ),

            const SizedBox(height: 40),

            // Animated "Welcome Back 💕" text
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome BacK 💕',
                  textStyle: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
            ),

            const SizedBox(height: 40),

            // Sign In Button with scaling effect
            _buildAnimatedButton(
              context,
              'SIGN IN',
              Colors.white,
              Colors.teal,
              SignInPage(),
            ),

            const SizedBox(height: 20),

            // Sign Up Button with scaling effect
            _buildAnimatedButton(
              context,
              'SIGN UP',
              Colors.teal,
              Colors.white,
              SignUpPage(),
            ),

            const Spacer(),

            // Social Media Text
            Text(
              'Login with Social Media',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Social Media Icons with ripple animation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.camera_alt_outlined, () {
                  // Instagram login functionality
                }),
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.alternate_email, () {
                  // Twitter login functionality
                }),
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.facebook, () {
                  // Facebook login functionality
                }),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  // Method to build animated buttons
  Widget _buildAnimatedButton(BuildContext context, String text, Color bgColor,
      Color textColor, Widget nextPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTapDown: (_) => setState(() {}),
        onTapUp: (_) => setState(() {}),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => nextPage));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              shadowColor: Colors.teal.withOpacity(0.5),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to build social media icons with ripple effect
  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}



