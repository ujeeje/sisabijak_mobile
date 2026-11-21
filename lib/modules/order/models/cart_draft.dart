import 'package:flutter/foundation.dart';

import '../../catalog/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  int get total => product.discountPrice * quantity;
}

/// Keranjang lokal CP1. Harga dan stok wajib divalidasi ulang oleh backend
/// saat integrasi checkout; draft ini belum membuat pesanan di server.
class CartDraft extends ChangeNotifier {
  static final CartDraft instance = CartDraft();
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => List.unmodifiable(_items.values);
  int get total => _items.values.fold(0, (sum, item) => sum + item.total);
  num get originalTotal => _items.values.fold<num>(
    0,
    (sum, item) => sum + item.product.realPrice * item.quantity,
  );

  int limit(Product product) => product.productStock.clamp(0, 10);

  bool add(Product product) {
    final quantity = (_items[product.productId]?.quantity ?? 0) + 1;
    if (quantity > limit(product) ||
        !product.endPickup.isAfter(DateTime.now())) {
      return false;
    }
    _items[product.productId] = CartItem(product: product, quantity: quantity);
    notifyListeners();
    return true;
  }

  void setQuantity(String productId, int quantity) {
    final item = _items[productId];
    if (item == null || quantity < 1 || quantity > limit(item.product)) return;
    _items[productId] = CartItem(product: item.product, quantity: quantity);
    notifyListeners();
  }

  void remove(String productId) {
    if (_items.remove(productId) != null) notifyListeners();
  }
}
