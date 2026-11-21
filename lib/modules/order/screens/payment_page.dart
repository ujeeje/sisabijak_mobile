import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../catalog/widgets/product_card.dart';
import '../models/cart_draft.dart';
import '../widgets/order_widgets.dart';
import 'cart_checkout_page.dart';
import 'my_orders_page.dart';

class PaymentPage extends StatelessWidget {
  final List<CartItem> items;
  const PaymentPage({super.key, this.items = const []});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Pembayaran'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    body: OrderBody(
      children: [
        const Text(
          'SisaBayarQR',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        const Text('Satu pembayaran untuk semua produk dalam satu checkout.'),
        const SizedBox(height: 20),
        const OrderNotice(
          'Ini ringkasan sebelum checkout. Belum ada transaksi atau QR pembayaran yang diterbitkan.',
        ),
        OrderPanel(
          title: 'Rincian pesanan',
          children: [
            if (items.isEmpty) const Text('Belum ada produk yang dipilih.'),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.product.productName} × ${item.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(item.product.merchantName),
                    Text(formatRupiah(item.total)),
                  ],
                ),
              ),
            ),
            const Divider(),
            Text(
              'Total ${formatRupiah(items.fold<int>(0, (sum, item) => sum + item.total))}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const OrderPanel(
          title: 'QR pembayaran',
          children: [
            OrderEmptyState(
              icon: Icons.qr_code_2,
              title: 'Belum ada QR pembayaran',
              message: 'QR dan batas waktu pembayaran akan tampil setelah pesanan berhasil dibuat.',
            ),
            FilledButton(onPressed: null, child: Text('Buat Pesanan')),
            SizedBox(height: 8),
            Text(
              'Checkout dan pembayaran belum tersedia pada tahap ini.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CartCheckoutPage()),
              );
            }
          },
          child: const Text('Kembali ke Keranjang'),
        ),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyOrdersPage()),
          ),
          child: const Text('Lihat Pesanan Saya'),
        ),
      ],
    ),
  );
}
