import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pembayaran'),
      ),
      body: const Center(
        child: Text(
          'Halaman Pembayaran',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
