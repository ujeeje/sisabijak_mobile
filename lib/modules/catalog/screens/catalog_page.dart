import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants/api_endpoints.dart';
import '../../../common/constants/colors.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

// halaman katalog: search, filter harga, daftar produk
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final _searchController = TextEditingController();

  // filter harga yang lagi dipilih, nilainya sama kayak di web
  String _harga = "all";
  final Map<String, String> _pilihanHarga = {
    "all": "All",
    "lt15": "< Rp15.000",
    "15to25": "Rp15.000 - Rp25.000",
    "gt25": "> Rp25.000",
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ambil data produk dari django (asinkron), terus json-nya diubah jadi list Product
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(ApiEndpoints.catalogProducts).replace(
      queryParameters: {"q": _searchController.text.trim(), "harga": _harga},
    );
    final response = await http.get(url);
    final List data = jsonDecode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Makanan Surplus'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // search bar, data diambil ulang pas user tekan enter
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Cari makanan atau toko",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          // chip filter harga
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _pilihanHarga.entries.map((pilihan) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(pilihan.value),
                    selected: _harga == pilihan.key,
                    onSelected: (_) => setState(() => _harga = pilihan.key),
                  ),
                );
              }).toList(),
            ),
          ),
          // daftar produk
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Gagal memuat katalog."));
                }
                final products = snapshot.data!;
                if (products.isEmpty) {
                  return const Center(child: Text("Belum ada produk yang cocok."));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      product: product,
                      // klik kartu -> buka halaman detail produk
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(productId: product.productId),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
