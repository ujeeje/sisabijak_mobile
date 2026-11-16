import 'package:flutter/material.dart';

class ConsumerProfilePage extends StatelessWidget {
  const ConsumerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Consumer'),
      ),
      body: const Center(
        child: Text(
          'Profil Consumer',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
