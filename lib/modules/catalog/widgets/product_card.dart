import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../models/product.dart';

// 15000 -> Rp15.000
String formatRupiah(num angka) {
  final teks = angka.round().toString();
  final hasil = StringBuffer();
  for (int i = 0; i < teks.length; i++) {
    // kasih titik tiap 3 angka dari belakang
    if (i > 0 && (teks.length - i) % 3 == 0) hasil.write(".");
    hasil.write(teks[i]);
  }
  return "Rp$hasil";
}

// DateTime -> "21:00"
String formatJam(DateTime waktu) {
  final jam = waktu.hour.toString().padLeft(2, "0");
  final menit = waktu.minute.toString().padLeft(2, "0");
  return "$jam:$menit";
}

// foto produk, kalau ga ada fotonya muncul tulisan "Product Photo"
class ProductPhoto extends StatelessWidget {
  final String url;
  final double height;

  const ProductPhoto({super.key, required this.url, this.height = 140});

  @override
  Widget build(BuildContext context) {
    final kosong = Container(
      height: height,
      width: double.infinity,
      color: const Color(0xFFF3F0ED),
      alignment: Alignment.center,
      child: const Text("Product Photo", style: TextStyle(color: AppColors.textSecondary)),
    );
    if (url.isEmpty) return kosong;
    return Image.network(
      url,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      // kalau fotonya gagal dimuat, tampilin kotak kosong aja
      errorBuilder: (context, error, stackTrace) => kosong,
    );
  }
}

// kartu 1 produk di halaman katalog
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductPhoto(url: product.photoUrl),
                // badge diskon di pojok kiri atas foto
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "-${product.discountRate.round()}%",
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // nama toko + rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.merchantName,
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                      Text(
                        product.reviewCount > 0 ? "★ ${product.avgRating} (${product.reviewCount})" : "New",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.productName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  // harga diskon + harga asli dicoret
                  Row(
                    children: [
                      Text(
                        formatRupiah(product.discountPrice),
                        style: const TextStyle(
                          fontSize: 16,
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
                  const SizedBox(height: 4),
                  Text(
                    "${product.productStock} left - Pickup ${formatJam(product.startPickup)} - ${formatJam(product.endPickup)}",
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
