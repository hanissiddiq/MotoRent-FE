
import 'package:http/http.dart' as http;

class LocationService {
  static Future<void> sendLocation(int loanId, double lat, double lng) async {
    final url = Uri.parse('https://your-backend-url/api/locations');
    await http.post(url, body: {
      'loan_id': '$loanId',
      'lat': '$lat',
      'lng': '$lng',
    });
  }
}
