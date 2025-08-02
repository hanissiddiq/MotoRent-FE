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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login gagal')));
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Car.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 133, 131, 204),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Time to Rent your Favorite Car, Lets Sign In',
                  style: TextStyle(color: Colors.grey.shade200, fontSize: 18),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: TextStyle(fontSize: 16),
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey.shade200),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      fillColor: Color(0xff161627),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    style: TextStyle(fontSize: 16),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey.shade200),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      fillColor: Color(0xff161627),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "You don't have an account? Sign Up",
                  style: TextStyle(color: Colors.grey.shade200, fontSize: 16),
                ),
                SizedBox(height: 20),
                Container(
                  height:
                      50, // disarankan lebih tinggi dari 20 agar tombol terlihat baik
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff161627),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ), // agar tombol tidak terlalu tipis
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
