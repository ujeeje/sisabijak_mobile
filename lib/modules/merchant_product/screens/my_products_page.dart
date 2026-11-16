import 'package:flutter/material.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Saya (Merchant)'),
      ),
      body: const Center(
        child: Text(
          'Produk Saya (Merchant)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
