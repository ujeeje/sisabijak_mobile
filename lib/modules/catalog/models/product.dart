// model 1 produk, isinya sama kayak json dari /api/v1/catalog/products/

class Product {
  final String productId;
  final String productName;
  final String merchantName;
  final String address;
  final int productStock;
  final double realPrice;
  final double discountRate;
  final int discountPrice;
  final DateTime startPickup;
  final DateTime endPickup;
  final String photoUrl;
  final double avgRating;
  final int reviewCount;
  // cuma ada di endpoint detail, di endpoint list isinya false
  final bool canReview;

  Product({
    required this.productId,
    required this.productName,
    required this.merchantName,
    required this.address,
    required this.productStock,
    required this.realPrice,
    required this.discountRate,
    required this.discountPrice,
    required this.startPickup,
    required this.endPickup,
    required this.photoUrl,
    required this.avgRating,
    required this.reviewCount,
    required this.canReview,
  });

  // ubah map json dari django jadi object Product
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        merchantName: json["merchant_name"] ?? "",
        address: json["address"] ?? "",
        productStock: json["product_stock"],
        // real_price & discount_rate dikirim django dalam bentuk teks ("60000.00"), jadi diubah ke angka dulu
        realPrice: double.parse(json["real_price"].toString()),
        discountRate: double.parse(json["discount_rate"].toString()),
        discountPrice: json["discount_price"],
        // .toLocal() biar jamnya ikut zona waktu hp (WIB)
        startPickup: DateTime.parse(json["start_pickup"]).toLocal(),
        endPickup: DateTime.parse(json["end_pickup"]).toLocal(),
        photoUrl: json["photo_url"] ?? "",
        avgRating: (json["avg_rating"] ?? 0).toDouble(),
        reviewCount: json["review_count"] ?? 0,
        canReview: json["can_review"] ?? false,
      );
}
