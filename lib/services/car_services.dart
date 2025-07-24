import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CarService {
  static Future<List<dynamic>> fetchCars() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse(
      'http://127.0.0.1:8000/api/cars',
    ); // gunakan 10.0.2.2 jika emulator
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Gagal load cars: ${response.statusCode} ${response.body}');
      return [];
    }
  }
}
