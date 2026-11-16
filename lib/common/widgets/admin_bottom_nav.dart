import 'package:flutter/material.dart';

// Placeholder Bottom Navigation untuk AdminBottomNav
// Items: Simulator Bayar, Profil
class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Item 1'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Item 2'),
      ],
    );
  }
}
