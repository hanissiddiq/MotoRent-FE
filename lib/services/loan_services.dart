import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth_services.dart';

class LoanService {
  static Future<bool> requestLoan(int carId) async {
    final token = await AuthService.getToken();
    final url = Uri.parse('http://10.0.2.2:8000/api/loans');

    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {'car_id': '$carId'},
    );

    if (response.statusCode != 200) {
      print('Gagal request loan: ${response.statusCode} - ${response.body}');
    }

    return response.statusCode == 200;
  }

  static Future<List<dynamic>> fetchLoanHistory() async {
    final token = await AuthService.getToken();
    final url = Uri.parse('http://10.0.2.2:8000/api/loans/history');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(
        'Gagal ambil riwayat pinjam: ${response.statusCode} - ${response.body}',
      );
      return [];
    }
  }
}
