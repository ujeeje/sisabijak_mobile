import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: const Center(
        child: Text(
          'Detail Produk',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
