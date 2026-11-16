import 'package:flutter/material.dart';

class LandingGuestPage extends StatelessWidget {
  const LandingGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page (Guest)'),
      ),
      body: const Center(
        child: Text(
          'Landing Page (Guest)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
