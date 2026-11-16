import 'package:flutter/material.dart';

class HomeConsumerPage extends StatelessWidget {
  const HomeConsumerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Consumer'),
      ),
      body: const Center(
        child: Text(
          'Beranda Consumer',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
