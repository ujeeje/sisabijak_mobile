import 'package:flutter/material.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
      ),
      body: const Center(
        child: Text(
          'Edit Produk',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
