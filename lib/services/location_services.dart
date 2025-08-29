import 'package:http/http.dart' as http;

class LocationService {
  static Future<void> sendLocation(int loanId, double lat, double lng) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/locations');
    await http.post(
      url,
      body: {'loan_id': '$loanId', 'lat': '$lat', 'lng': '$lng'},
    );
  }
}
