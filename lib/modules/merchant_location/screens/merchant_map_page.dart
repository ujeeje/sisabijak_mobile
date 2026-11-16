import 'package:flutter/material.dart';

class MerchantMapPage extends StatelessWidget {
  const MerchantMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Lokasi Merchant'),
      ),
      body: const Center(
        child: Text(
          'Peta Lokasi Merchant',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
