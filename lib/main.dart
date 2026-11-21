import 'package:flutter/material.dart';

import 'common/constants/colors.dart';
import 'modules/landing/screens/landing_guest_page.dart';
import 'modules/order/screens/cart_checkout_page.dart';
import 'modules/order/screens/payment_page.dart';
import 'modules/order/screens/my_orders_page.dart';
import 'modules/order/screens/merchant_orders_page.dart';
import 'modules/order/screens/qr_validator_page.dart';
import 'modules/order/screens/simulator_bayar_page.dart';

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
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      ),
      // Rute awal opsional untuk demonstrasi halaman CP1. Bukan autentikasi.
      initialRoute: const String.fromEnvironment(
        'ORDER_START_ROUTE',
        defaultValue: '/',
      ),
      routes: {
        '/': (_) => const LandingGuestPage(),
        '/orders/cart': (_) => const CartCheckoutPage(),
        '/orders/payment': (_) => const PaymentPage(),
        '/orders/my-orders': (_) => const MyOrdersPage(),
        '/orders/merchant': (_) => const MerchantOrdersPage(),
        '/orders/merchant/validate': (_) => const QrValidatorPage(),
        '/orders/simulator-bayar': (_) => const SimulatorBayarPage(),
      },
    );
  }
}
