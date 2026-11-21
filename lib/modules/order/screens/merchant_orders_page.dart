import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/widgets/merchant_bottom_nav.dart';
import '../../consumer_profile/screens/generic_profile_page.dart';
import '../../merchant_product/screens/my_products_page.dart';
import '../widgets/order_widgets.dart';
import 'qr_validator_page.dart';

class MerchantOrdersPage extends StatelessWidget {
  const MerchantOrdersPage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Incoming'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Validasi QR Klaim'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const QrValidatorPage()),
                ),
              ),
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                OrderBody(
                  children: [
                    OrderNotice(
                      'Daftar pesanan akan tampil setelah akun merchant dan layanan pesanan terhubung.',
                    ),
                    OrderEmptyState(
                      icon: Icons.inbox_outlined,
                      title: 'Belum ada pesanan masuk',
                      message: 'Pesanan yang sudah dibayar dan menunggu pengambilan akan tampil di sini.',
                    ),
                  ],
                ),
                OrderBody(
                  children: [
                    OrderPanel(
                      title: 'Saldo penjualan',
                      children: [
                        Text(
                          'Saldo belum tersedia',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: null,
                          child: Text('Cairkan Saldo'),
                        ),
                        Text(
                          'Saldo dan pencairan tersedia setelah layanan dompet terhubung.',
                        ),
                      ],
                    ),
                    OrderEmptyState(
                      icon: Icons.task_alt,
                      title: 'Belum ada riwayat redeem',
                      message: 'Pesanan yang berhasil diklaim konsumen akan tampil di sini.',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MerchantBottomNav(
        currentIndex: 1,
        onTap: (index) {
          final Widget? page = switch (index) {
            0 => const MyProductsPage(),
            2 => const GenericProfilePage(title: 'Profil Merchant'),
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
