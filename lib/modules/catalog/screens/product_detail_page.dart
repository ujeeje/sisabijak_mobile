import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants/api_endpoints.dart';
import '../../../common/constants/colors.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../widgets/product_card.dart';

// halaman detail produk: info produk + daftar review
class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  // ambil detail 1 produk dari django
  Future<Product> fetchProduct() async {
    final response = await http.get(Uri.parse(ApiEndpoints.catalogProductDetail(productId)));
    return Product.fromJson(jsonDecode(response.body));
  }

  // ambil semua review produk ini dari django
  Future<List<Review>> fetchReviews() async {
    final response = await http.get(Uri.parse(ApiEndpoints.catalogReviews(productId)));
    final List data = jsonDecode(response.body);
    return data.map((item) => Review.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Product>(
        future: fetchProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Gagal memuat produk."));
          }
          final product = snapshot.data!;
          return ListView(
            children: [
              ProductPhoto(url: product.photoUrl, height: 240),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.merchantName, style: const TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text(
                      product.productName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.reviewCount > 0
                          ? "★ ${product.avgRating} (${product.reviewCount} review)"
                          : "Belum ada review",
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          formatRupiah(product.discountPrice),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formatRupiah(product.realPrice),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // info stok, jam pickup, lokasi
                    _info(Icons.inventory_2_outlined, "${product.productStock} left"),
                    _info(
                      Icons.schedule,
                      "Pickup ${formatJam(product.startPickup)} - ${formatJam(product.endPickup)}",
                    ),
                    _info(Icons.location_on_outlined, product.address),
                    const SizedBox(height: 16),
                    // tombol pesan, nanti disambungin ke halaman keranjang (modul order)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Halaman keranjang segera hadir.")),
                          );
                        },
                        child: const Text("Pesan Sekarang"),
                      ),
                    ),
                    const Divider(height: 32),
                    const Text("Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _daftarReview(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 1 baris info pakai icon di kiri
  Widget _info(IconData icon, String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(child: Text(teks)),
        ],
      ),
    );
  }

  // daftar review, diambil terpisah dari detail produk
  Widget _daftarReview() {
    return FutureBuilder<List<Review>>(
      future: fetchReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Text("Gagal memuat review.");
        }
        final reviews = snapshot.data!;
        if (reviews.isEmpty) {
          return const Text("Belum ada review.", style: TextStyle(color: AppColors.textSecondary));
        }
        return Column(
          children: reviews.map((review) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(review.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(review.comment),
                trailing: Text(
                  "★" * review.rating,
                  style: const TextStyle(color: AppColors.secondary),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
