import 'package:flutter/material.dart';
import 'package:myapp/services/auth_services.dart';
import '../services/car_services.dart';
import '../services/loan_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> cars = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  void _loadCars() async {
    final data = await CarService.fetchCars();
    setState(() => cars = data);
  }

  void _requestLoan(int carId) async {
    final success = await LoanService.requestLoan(carId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil pinjam mobil'),
          backgroundColor: Color.fromARGB(255, 231, 155, 12),
        ),
      );
      // Update status mobil yang dipinjam
      setState(() {
        final index = cars.indexWhere((c) => c['id'] == carId);
        if (index != -1) {
          cars[index]['status'] = 'unavailable';
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal pinjam mobil'),
          backgroundColor: Color.fromARGB(255, 250, 17, 48),
        ),
      );
    }
  }

  Widget _buildStatusBadge(String status) {
    final isAvailable = status == 'available';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isAvailable ? 'Available' : 'Unavailable',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Mobil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();

              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: cars.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                final isAvailable = car['status'] == 'available';

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child:
                            // Image.asset('assets/Car2.jpg', // ganti dengan gambar mobil kamu
                            // child: Image.network(
                            // 'http://127.0.0.1:8000/storage/cars/car2.jpg', // URL dari API/database
                            car['image_url'] != null
                                ? Image.network(
                                    car['image_url'],
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/car-skeleton.jpg',
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(car['name'] ?? 'Mobil',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 4),
                                Text('Plat: ${car['plate_number']}'),
                                const SizedBox(height: 6),
                                _buildStatusBadge(car['status']),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: isAvailable
                                  ? () => _requestLoan(car['id'])
                                  : null,
                              child: const Text('Pinjam'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
