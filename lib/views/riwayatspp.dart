import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:presensi_flutter_test/services/history_payment/history_payment.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatSPPPage extends StatefulWidget {
  const RiwayatSPPPage({super.key});

  @override
  State<RiwayatSPPPage> createState() => _RiwayatSPPPageState();
}

class _RiwayatSPPPageState extends State<RiwayatSPPPage> {
  String selectedBulan = 'Januari';
  String selectedTahun = '2025';
  bool isLoading = true;
  List<String> bulanList = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  List<String> tahunList = ['2023', '2024', '2025'];
  List<dynamic> riwayatSPP = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null).then((_) => fetchData());
  }

  Future<void> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        final history = await getHistoryPayment(token);
        setState(() {
          riwayatSPP = history;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (_) {
      setState(() {
        riwayatSPP = [];
        isLoading = false;
      });
    }
  }

  Widget buildDropdowns() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedBulan,
              items: bulanList.map((bulan) => DropdownMenuItem(value: bulan, child: Text(bulan))).toList(),
              onChanged: (val) => setState(() => selectedBulan = val!),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedTahun,
              items: tahunList.map((tahun) => DropdownMenuItem(value: tahun, child: Text(tahun))).toList(),
              onChanged: (val) => setState(() => selectedTahun = val!),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
            child: const Icon(Icons.search, size: 20),
          ),
        ],
      ),
    );
  }

  Widget buildRiwayatList() {
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
        final tanggal = _formatTanggal(data["last_update"]);
        final jumlah = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(double.tryParse(data['amount'].toString()) ?? 0);
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

  String _formatTanggal(String? dateString) {
    if (dateString == null) return "-";
    final date = DateTime.tryParse(dateString);
    if (date == null) return "-";
    final hariList = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
    final bulanList = [
      "Januari", "Februari", "Maret", "April", "Mei", "Juni",
      "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ];
    final hari = hariList[date.weekday % 7];
    final bulan = bulanList[date.month - 1];
    return "$hari, ${date.day} $bulan ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const ProfileHeader(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const HeaderCard(title: "Riwayat Pembayaran SPP"),
                        buildDropdowns(),
                        const SizedBox(height: 10),
                        Expanded(child: buildRiwayatList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
