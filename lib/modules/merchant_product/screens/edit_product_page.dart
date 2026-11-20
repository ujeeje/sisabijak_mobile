import 'package:flutter/material.dart';
import '../../../common/constants/colors.dart';

// Kerangka Halaman Form Edit Produk
class EditProductPage extends StatefulWidget {
  final String initialProductName;

  const EditProductPage({
    super.key,
    this.initialProductName = 'Croissant Almond Surplus',
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController _nameController;
  final _stockController = TextEditingController(text: '5');
  final _priceController = TextEditingController(text: '30000');
  final _discountController = TextEditingController(text: '50');
  String _status = 'Available';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialProductName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _handleSave() {
    // Navigasi simpan perubahan (kembali ke Produk Saya)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perubahan produk berhasil disimpan (simulasi kerangka)!'),
        backgroundColor: AppColors.primary,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Kerangka Input Nama Produk
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Produk / Makanan',
                prefixIcon: Icon(Icons.fastfood_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Kerangka Input Status & Stok (2 Kolom)
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Available', child: Text('Available')),
                      DropdownMenuItem(value: 'Sold Out', child: Text('Sold Out')),
                      DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _status = val);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stok',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Kerangka Input Harga Asli & Diskon
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Harga Asli',
                      prefixText: 'Rp ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _discountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Diskon',
                      suffixText: '%',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Kerangka Jadwal Pickup
            const Text(
              'Jadwal Penjemputan (Pickup Schedule)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.access_time),
                    label: const Text('Mulai: 17:00 WIB'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.alarm_off),
                    label: const Text('Selesai: 21:00 WIB'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Navigasi Tombol Simpan Perubahan
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Simpan Perubahan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // Navigasi Tombol Batal
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }
}
