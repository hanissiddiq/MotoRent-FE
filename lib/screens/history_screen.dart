
import 'package:flutter/material.dart';
import '../services/loan_service.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> loans = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    final data = await LoanService.fetchLoanHistory();
    setState(() => loans = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Peminjaman')),
      body: ListView.builder(
        itemCount: loans.length,
        itemBuilder: (context, index) {
          final loan = loans[index];
          return ListTile(
            title: Text('Mobil ID: ${loan['car_id']}'),
            subtitle: Text('Status: ${loan['status']}, Tgl: ${loan['start_time'] ?? '-'}'),
          );
        },
      ),
    );
  }
}
