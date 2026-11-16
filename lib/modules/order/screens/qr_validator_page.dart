import 'package:flutter/material.dart';

class QrValidatorPage extends StatelessWidget {
  const QrValidatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validasi QR Klaim'),
      ),
      body: const Center(
        child: Text(
          'Validasi QR Klaim',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
