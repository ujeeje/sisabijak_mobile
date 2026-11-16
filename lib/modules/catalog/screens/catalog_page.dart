import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Makanan Surplus'),
      ),
      body: const Center(
        child: Text(
          'Katalog Makanan Surplus',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
