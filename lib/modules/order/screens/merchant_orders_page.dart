import 'package:flutter/material.dart';

class MerchantOrdersPage extends StatelessWidget {
  const MerchantOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk (Merchant)'),
      ),
      body: const Center(
        child: Text(
          'Pesanan Masuk (Merchant)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
