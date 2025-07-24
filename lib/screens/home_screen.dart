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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Berhasil pinjam mobil' : 'Gagal pinjam'),
      ),
    );
  }

  //tombol pinjam belum berfungsi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Mobil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return ListTile(
            title: Text(car['name'] ?? 'Mobil'),
            subtitle: Text('Plat: ${car['plate_number'] ?? '-'}'),
            trailing: ElevatedButton(
              child: Text('Pinjam'),
              onPressed: () => _requestLoan(car['id']),
            ),
          );
        },
      ),
    );
  }
}
