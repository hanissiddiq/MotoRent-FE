
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final url = Uri.parse('https://your-backend-url/api/login');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return true;
    }
    return false;
  }

  static Future<bool> register(String name, String email, String password) async {
    final url = Uri.parse('https://your-backend-url/api/register');
    final response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
    });

    return response.statusCode == 201;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
