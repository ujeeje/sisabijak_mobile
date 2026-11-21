import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../catalog/models/product.dart';
import '../../catalog/screens/catalog_page.dart';
import '../../catalog/widgets/product_card.dart';
import '../models/cart_draft.dart';
import '../widgets/order_widgets.dart';
import 'my_orders_page.dart';
import 'payment_page.dart';

class CartCheckoutPage extends StatefulWidget {
  final Product? initialProduct;
  final CartDraft? cart;
  const CartCheckoutPage({super.key, this.initialProduct, this.cart});

  @override
  State<CartCheckoutPage> createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  late final CartDraft cart;
  bool couldAdd = true;

  @override
  void initState() {
    super.initState();
    cart = widget.cart ?? CartDraft.instance;
    if (widget.initialProduct != null) {
      couldAdd = cart.add(widget.initialProduct!);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Keranjang'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          tooltip: 'Pesanan Saya',
          icon: const Icon(Icons.receipt_long_outlined),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyOrdersPage()),
          ),
        ),
      ],
    ),
    body: AnimatedBuilder(
      animation: cart,
      builder: (context, _) => OrderBody(
        children: [
          const Text(
            'Periksa pesananmu',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pilih jumlah makanan dan periksa jadwal pengambilannya.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          if (!couldAdd)
            const OrderNotice(
              'Produk tidak ditambahkan: stok, batas jumlah, atau waktu pengambilannya sudah tidak tersedia.',
            ),
          if (cart.items.isEmpty)
            OrderEmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'Keranjang masih kosong',
              message: 'Pilih makanan dari katalog untuk mulai menyelamatkan makanan.',
              action: FilledButton.icon(
                icon: const Icon(Icons.storefront_outlined),
                label: const Text('Lihat Katalog'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CatalogPage()),
                ),
              ),
            )
          else ...[
            ...cart.items.map((item) => _itemCard(item)),
            OrderPanel(
              title: 'Ringkasan pesanan',
              children: [
                Text('${cart.items.length} produk dipilih'),
                const SizedBox(height: 12),
                Text(
                  formatRupiah(cart.total),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hemat ${formatRupiah(cart.originalTotal - cart.total)} dari harga normal',
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentPage(items: cart.items),
                    ),
                  ),
                  child: const Text('Lihat Ringkasan Pembayaran'),
                ),
              ],
            ),
            const OrderNotice(
              'Keranjang ini disimpan sementara di aplikasi. Pesanan belum dikirim ke toko.',
            ),
          ],
        ],
      ),
    ),
  );

  Widget _itemCard(CartItem item) => OrderPanel(
    title: item.product.productName,
    children: [
      Text(
        item.product.merchantName,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 12),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ProductPhoto(url: item.product.photoUrl, height: 120),
      ),
      const SizedBox(height: 12),
      Text(
        formatRupiah(item.total),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'Ambil ${item.product.startPickup.toLocal().day}/${item.product.startPickup.toLocal().month} · ${formatJam(item.product.startPickup.toLocal())}–${formatJam(item.product.endPickup.toLocal())}',
      ),
      if (item.product.address.isNotEmpty) Text(item.product.address),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            tooltip: 'Kurangi ${item.product.productName}',
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: item.quantity > 1
                ? () => cart.setQuantity(
                    item.product.productId,
                    item.quantity - 1,
                  )
                : null,
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            tooltip: 'Tambah ${item.product.productName}',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: item.quantity < cart.limit(item.product)
                ? () => cart.setQuantity(
                    item.product.productId,
                    item.quantity + 1,
                  )
                : null,
          ),
          TextButton.icon(
            onPressed: () => cart.remove(item.product.productId),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Hapus'),
          ),
        ],
      ),
    ],
  );
}
