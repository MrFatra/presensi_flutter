import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_flutter_test/utils/date_formater.dart';

class RiwayatList extends StatelessWidget {
  final bool isLoading;
  final List<dynamic> riwayatSPP;

  const RiwayatList({
    super.key,
    required this.isLoading,
    required this.riwayatSPP,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (riwayatSPP.isEmpty) {
      return const Center(child: Text('Tidak ada data riwayat pembayaran.', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: riwayatSPP.length,
      itemBuilder: (context, index) {
        final data = riwayatSPP[index];
        final tanggal = formatTanggal(data["last_update"]);
        final jumlah = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
            .format(double.tryParse(data['amount'].toString()) ?? 0);
        final icon = data['status'] == 'lunas' ? Icons.check_circle : Icons.cancel;
        final iconColor = data['status'] == 'lunas' ? Colors.green : Colors.red;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tanggal, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Jumlah: $jumlah', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const Spacer(),
              Icon(icon, color: iconColor),
            ],
          ),
        );
      },
    );
  }
}
