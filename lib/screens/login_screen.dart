import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  void _login() async {
    setState(() => loading = true);
    final success = await AuthService.login(
      _emailController.text,
      _passwordController.text,
    );
    setState(() => loading = false);
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login gagal'),
          backgroundColor: Color.fromARGB(255, 231, 155, 12),
          // behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Car.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xff161627).withOpacity(0.8),
                  Color(0xff161627),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Login form
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Color.fromARGB(255, 216, 215, 243),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Time to Rent your Favorite Car, Let\'s Sign In',
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 18),
                  ),
                  SizedBox(height: 20),

                  // Email input
                  Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey.shade200),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 231, 155, 12)),
                        ),
                        fillColor: Color(0xff161627),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Password input
                  Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey.shade200),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 231, 155, 12)),
                        ),
                        fillColor: Color(0xff161627),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Login button or loading
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 231, 155, 12)))
                        : ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 231, 155, 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey.shade200, fontSize: 16),
                  ),

                  // Text link ke register
                  GestureDetector(
                    onTap: _register,
                    child: Text(
                      "Sign Up here",
                      style: TextStyle(
                          color: Color.fromARGB(255, 231, 155, 12),
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
