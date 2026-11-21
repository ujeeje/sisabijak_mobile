import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../widgets/order_widgets.dart';
import 'merchant_orders_page.dart';

class QrValidatorPage extends StatefulWidget {
  const QrValidatorPage({super.key});

  @override
  State<QrValidatorPage> createState() => _QrValidatorPageState();
}

class _QrValidatorPageState extends State<QrValidatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  String? _previewCode;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Validasi QR Klaim'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    body: OrderBody(
      children: [
        const Text(
          'Pengambilan pesanan',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Gunakan QR klaim dari konsumen saat makanan diambil di toko.',
        ),
        const SizedBox(height: 20),
        const OrderNotice(
          'Satu kode klaim digunakan untuk produk dari toko yang sama dalam satu checkout.',
        ),
        Form(
          key: _formKey,
          child: OrderPanel(
            title: 'Kode klaim konsumen',
            children: [
              TextFormField(
                controller: _code,
                textCapitalization: TextCapitalization.characters,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Kode klaim',
                  hintText: 'SBQR-XXXXXXXX',
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() => _previewCode = null),
                validator: (value) {
                  final code = (value ?? '').trim().toUpperCase();
                  if (code.isEmpty) return 'Masukkan kode klaim konsumen.';
                  if (!RegExp(r'^SBQR-[A-Z0-9-]+$').hasMatch(code)) {
                    return 'Kode klaim harus diawali SBQR-.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(
                      () => _previewCode = _code.text.trim().toUpperCase(),
                    );
                  }
                },
                icon: const Icon(Icons.search),
                label: const Text('Periksa Format Kode'),
              ),
              const OutlinedButton(
                onPressed: null,
                child: Text('Buka Kamera Scanner'),
              ),
            ],
          ),
        ),
        if (_previewCode != null)
          OrderPanel(
            title: 'Kode yang akan diperiksa',
            children: [
              SelectableText(
                _previewCode!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Format kode sesuai. Kecocokan pesanan, status pembayaran, dan toko belum diperiksa.',
              ),
            ],
          ),
        const OrderNotice(
          'Pemeriksaan pesanan dan pemindaian kamera belum tersedia pada tahap ini. Kode tidak akan menyelesaikan pesanan.',
        ),
        const FilledButton(onPressed: null, child: Text('Konfirmasi Klaim')),
        TextButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MerchantOrdersPage()),
              );
            }
          },
          child: const Text('Kembali ke Pesanan Masuk'),
        ),
      ],
    ),
  );
}
