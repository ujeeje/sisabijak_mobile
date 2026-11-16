import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
      ),
      body: const Center(
        child: Text(
          'Pesanan Saya',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
