
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarService {
  static Future<List<dynamic>> fetchCars() async {
    final url = Uri.parse('https://your-backend-url/api/cars');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }
}
