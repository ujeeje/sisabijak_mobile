import 'package:flutter/material.dart';

class SimulatorBayarPage extends StatelessWidget {
  const SimulatorBayarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulator Bayar (Admin)'),
      ),
      body: const Center(
        child: Text(
          'Simulator Bayar (Admin)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
