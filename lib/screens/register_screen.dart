<<<<<<< HEAD

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
=======
import 'package:flutter/material.dart';
import '../services/auth_services.dart';
>>>>>>> 27ce800 (add logic request to API)

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool loading = false;

  void _register() async {
    setState(() => loading = true);
    final success = await AuthService.register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );
    setState(() => loading = false);
    if (success) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
<<<<<<< HEAD
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi gagal')),
      );
=======
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registrasi gagal')));
>>>>>>> 27ce800 (add logic request to API)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register', style: TextStyle(fontSize: 24)),
<<<<<<< HEAD
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nama')),
              TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
=======
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
>>>>>>> 27ce800 (add logic request to API)
              SizedBox(height: 20),
              loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(onPressed: _register, child: Text('Daftar')),
            ],
          ),
        ),
      ),
    );
  }
}
