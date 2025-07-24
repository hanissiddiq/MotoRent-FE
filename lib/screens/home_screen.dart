
import 'package:flutter/material.dart';
import '../services/car_service.dart';
import '../services/loan_service.dart';

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
      SnackBar(content: Text(success ? 'Berhasil pinjam mobil' : 'Gagal pinjam')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Mobil')),
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
