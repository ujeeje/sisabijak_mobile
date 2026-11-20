import 'package:flutter/material.dart';
import '../../../common/constants/colors.dart';
import '../../../common/widgets/merchant_bottom_nav.dart';
import '../../consumer_profile/screens/generic_profile_page.dart';
import '../../order/screens/merchant_orders_page.dart';
import 'add_product_page.dart';
import 'edit_product_page.dart';

// Kerangka Halaman Produk Saya (Merchant)
class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  // Data dummy untuk kerangka tampilan produk
  final List<Map<String, dynamic>> _dummyProducts = [
    {
      'id': 'PRD-001',
      'name': 'Croissant Almond Surplus',
      'stock': 5,
      'status': 'Tersedia',
      'original_price': 'Rp 30.000',
      'discount_price': 'Rp 15.000',
      'discount': '50%',
      'pickup_time': '17:00 - 21:00 WIB',
    },
    {
      'id': 'PRD-002',
      'name': 'Nasi Bento Ayam Teriyaki',
      'stock': 3,
      'status': 'Tersedia',
      'original_price': 'Rp 28.000',
      'discount_price': 'Rp 14.000',
      'discount': '50%',
      'pickup_time': '18:30 - 21:00 WIB',
    },
    {
      'id': 'PRD-003',
      'name': 'Roti Manis Coklat Keju',
      'stock': 0,
      'status': 'Habis',
      'original_price': 'Rp 20.000',
      'discount_price': 'Rp 10.000',
      'discount': '50%',
      'pickup_time': '16:00 - 19:30 WIB',
    },
  ];

  void _showDeleteDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Produk?'),
        content: Text('Apakah Anda yakin ingin menghapus "$productName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produk "$productName" dihapus (simulasi navigasi).'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Saya (Merchant)'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _dummyProducts.length,
        itemBuilder: (context, index) {
          final product = _dummyProducts[index];
          final isAvailable = product['status'] == 'Tersedia';

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris Status & ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['id']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product['status']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isAvailable ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Nama Produk
                  Text(
                    product['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Info Stok & Jadwal Pickup
                  Text(
                    'Stok: ${product['stock']} porsi  •  Pickup: ${product['pickup_time']}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8),

                  // Info Harga
                  Row(
                    children: [
                      Text(
                        product['discount_price']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        product['original_price']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product['discount']!,
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),

                  // Navigasi Tombol Edit & Hapus
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _showDeleteDialog(context, product['name']!),
                        icon: const Icon(Icons.delete_outline, size: 16),
                        label: const Text('Hapus'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigasi ke Form Edit Produk
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProductPage(
                                initialProductName: product['name']!,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Navigasi Floating Action Button: Tambah Produk
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Produk'),
      ),

      // Navigasi Bottom Navigation Bar Merchant
      bottomNavigationBar: MerchantBottomNav(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MerchantOrdersPage()),
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
