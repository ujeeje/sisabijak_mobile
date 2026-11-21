import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/widgets/consumer_bottom_nav.dart';
import '../../catalog/screens/catalog_page.dart';
import '../../consumer_profile/screens/consumer_profile_page.dart';
import '../../landing/screens/home_consumer_page.dart';
import '../widgets/order_widgets.dart';
import 'cart_checkout_page.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Buka Keranjang',
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartCheckoutPage()),
            ),
          ),
        ],
        bottom: const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Aktif'),
            Tab(text: 'Riwayat'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          OrderBody(
            children: [
              OrderNotice(
                'Daftar pesanan akan tampil setelah akun dan layanan pesanan terhubung.',
              ),
              OrderEmptyState(
                icon: Icons.receipt_long_outlined,
                title: 'Belum ada pesanan aktif',
                message: 'Pesanan menunggu pembayaran dan QR klaim siap ambil akan tampil di sini.',
              ),
            ],
          ),
          OrderBody(
            children: [
              OrderEmptyState(
                icon: Icons.history,
                title: 'Belum ada riwayat pesanan',
                message: 'Pesanan yang selesai atau kedaluwarsa akan tersimpan di sini.',
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: ConsumerBottomNav(
        currentIndex: 2,
        onTap: (index) {
          final Widget? page = switch (index) {
            0 => const HomeConsumerPage(),
            1 => const CatalogPage(),
            3 => const ConsumerProfilePage(),
            _ => null,
          };
          if (page != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          }
        },
      ),
    ),
  );
}
