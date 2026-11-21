import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/widgets/admin_bottom_nav.dart';
import '../../consumer_profile/screens/generic_profile_page.dart';
import '../widgets/order_widgets.dart';

class SimulatorBayarPage extends StatelessWidget {
  const SimulatorBayarPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Simulator Pembayaran'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    body: const OrderBody(
      children: [
        Text(
          'SisaBayarQR',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Khusus admin untuk memeriksa dan mengonfirmasi pembayaran konsumen.',
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: Text('1. Unggah QR')),
            Chip(label: Text('2. Periksa pesanan')),
            Chip(label: Text('3. Konfirmasi')),
          ],
        ),
        SizedBox(height: 16),
        OrderPanel(
          title: 'Unggah SisaBayarQR',
          children: [
            OrderEmptyState(
              icon: Icons.upload_file_outlined,
              title: 'Belum ada QR dipilih',
              message: 'Gunakan PNG asli SisaBayarQR yang diunduh konsumen.',
            ),
            OutlinedButton(onPressed: null, child: Text('Pilih Gambar QR')),
          ],
        ),
        OrderPanel(
          title: 'Rincian pembayaran',
          children: [
            Text(
              'Rincian pesanan, total tagihan, dan status pembayaran muncul setelah QR berhasil diperiksa.',
            ),
            SizedBox(height: 16),
            FilledButton(onPressed: null, child: Text('Konfirmasi Pembayaran')),
          ],
        ),
        OrderNotice(
          'Unggah, pemeriksaan QR, dan konfirmasi pembayaran belum tersedia pada tahap ini.',
        ),
      ],
    ),
    bottomNavigationBar: AdminBottomNav(
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const GenericProfilePage(title: 'Profil Admin'),
            ),
          );
        }
      },
    ),
  );
}
