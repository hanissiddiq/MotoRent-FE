
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class LoanService {
  static Future<bool> requestLoan(int carId) async {
    final token = await AuthService.getToken();
    final url = Uri.parse('https://your-backend-url/api/loans');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer \$token',
    }, body: {
      'car_id': '\$carId',
    });

    return response.statusCode == 200;
  }

  static Future<List<dynamic>> fetchLoanHistory() async {
    final token = await AuthService.getToken();
    final url = Uri.parse('https://your-backend-url/api/loans/history');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer \$token',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }
}
