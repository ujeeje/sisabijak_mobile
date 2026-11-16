import 'package:flutter/material.dart';

class CartCheckoutPage extends StatelessWidget {
  const CartCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang & Checkout'),
      ),
      body: const Center(
        child: Text(
          'Keranjang & Checkout',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
