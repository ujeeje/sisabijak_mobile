import 'package:flutter/material.dart';

class GenericProfilePage extends StatelessWidget {
  const GenericProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
      ),
      body: const Center(
        child: Text(
          'Profil Pengguna',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
