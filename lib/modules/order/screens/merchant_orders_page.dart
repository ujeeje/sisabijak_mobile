import 'package:flutter/material.dart';
import '../../../common/constants/colors.dart';
import '../../../common/widgets/merchant_bottom_nav.dart';
import '../../consumer_profile/screens/generic_profile_page.dart';
import '../../merchant_product/screens/my_products_page.dart';

class MerchantOrdersPage extends StatelessWidget {
  const MerchantOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk (Merchant)'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Pesanan Masuk (Merchant)',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: MerchantBottomNav(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyProductsPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const GenericProfilePage(title: 'Profil Merchant'),
              ),
            );
          }
        },
      ),
    );
  }
}
