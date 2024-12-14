import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../services/shared_preferences_service.dart';
import 'sign_up_page.dart';
import 'dashboard_page.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade300,
              Colors.teal.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo with scaling effect
              AnimatedScale(
                scale: 1.2,
                duration: Duration(seconds: 1),
                child: Image.asset(
                  'lib/assets/5.png', // Replace with your logo path
                  height: 100,
                ),
              ),
              SizedBox(height: 20),

              // Animated "Sign In" text
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'SIGN IN',
                    textStyle: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: Duration(milliseconds: 200), // Speed of typing
                  ),
                ],
                totalRepeatCount: 1,
              ),
              SizedBox(height: 40),

              // Input fields with animations
              _buildAnimatedTextField(
                controller: phoneController,
                labelText: "Phone Number",
              ),
              SizedBox(height: 10),
              _buildAnimatedTextField(
                controller: passwordController,
                labelText: "Password",
                obscureText: true,
              ),

              SizedBox(height: 20),

              // Sign In Button with scaling effect
              _buildAnimatedButton(context, "Sign In"),

              SizedBox(height: 20),

              // Navigate to Sign Up if user doesn't have an account
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build animated text fields
  Widget _buildAnimatedTextField(
      {required TextEditingController controller,
      required String labelText,
      bool obscureText = false}) {
    return AnimatedScale(
      scale: 1.0,
      duration: Duration(seconds: 1),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }

  // Method to build animated buttons
  Widget _buildAnimatedButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTapDown: (_) => {},
        onTapUp: (_) => {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              String phone = phoneController.text;
              String password = passwordController.text;

              var user = await sharedPreferencesService.getUser(phone);

              if (user != null && user.password == password) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login successful")),
                );

                // Navigate to the Dashboard page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid phone or password")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
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
                color: Colors.teal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
