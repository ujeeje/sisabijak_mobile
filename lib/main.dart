import 'package:flutter/material.dart';
import 'common/constants/colors.dart';
import 'modules/landing/screens/landing_guest_page.dart';

void main() {
  runApp(const SisaBijakApp());
}

class SisaBijakApp extends StatelessWidget {
  const SisaBijakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SisaBijak Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const LandingGuestPage(),
    );
  }
}
