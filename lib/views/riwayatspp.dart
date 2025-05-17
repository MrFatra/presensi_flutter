import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:presensi_flutter_test/services/history_payment/history_payment.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';

class RiwayatSPPPage extends StatefulWidget {
  const RiwayatSPPPage({super.key});

  @override
  State<RiwayatSPPPage> createState() => _RiwayatSPPPageState();
}

class _RiwayatSPPPageState extends State<RiwayatSPPPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null).then((_) {
      fetchData();
    });
  }

  String selectedBulan = 'Januari';
  String selectedTahun = '2025';
  bool isLoading = true;
  List<String> bulanList = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  List<String> tahunList = ['2023', '2024', '2025'];

  List<dynamic> riwayatSPP = [];

  Future<void> fetchData() async {
    try {
      final token = '12|lcC3ambWlVbcnJq5tEwcFiN5KEuVgbQHWH6NCUKF02294b5e';
      if (token != null) {
        final history = await getHistoryPayment(token);
        setState(() {
          riwayatSPP = history;
        });
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      setState(() {
        riwayatSPP = [];
      });
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      bottomNavigationBar: BottomNavbar(currentIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  HeaderCard(title: "Riwayat Pembayaran SPP"),

                  // Dropdown Bulan Tahun + Cari
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedBulan,
                            items: bulanList.map((bulan) {
                              return DropdownMenuItem(
                                  value: bulan, child: Text(bulan));
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedBulan = val!;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedTahun,
                            items: tahunList.map((tahun) {
                              return DropdownMenuItem(
                                  value: tahun, child: Text(tahun));
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedTahun = val!;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi cari bisa ditambahkan di sini
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                          ),
                          child: const Icon(Icons.search, size: 20),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // List riwayat pembayaran
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : riwayatSPP.isEmpty
                            ? const Center(
                                child: Text(
                                  'Tidak ada data riwayat pembayaran.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: riwayatSPP.length,
                                itemBuilder: (context, index) {
                                  final data = riwayatSPP[index];
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                                // Format tanggal lokal Indonesia + hari (contoh: Kamis, 20 Juni 2024)
                                                (() {
                                                  if (data["last_update"] == null) return "-";
                                                  final date = DateTime.tryParse(data["last_update"]);
                                                  if (date == null) return "-";
                                                  // Format hari dan tanggal
                                                  final hari = [
                                                  "Minggu",
                                                  "Senin",
                                                  "Selasa",
                                                  "Rabu",
                                                  "Kamis",
                                                  "Jumat",
                                                  "Sabtu"
                                                  ][date.weekday % 7];
                                                  final bulan = [
                                                  "Januari",
                                                  "Februari",
                                                  "Maret",
                                                  "April",
                                                  "Mei",
                                                  "Juni",
                                                  "Juli",
                                                  "Agustus",
                                                  "September",
                                                  "Oktober",
                                                  "November",
                                                  "Desember"
                                                  ][date.month - 1];
                                                  return "$hari, ${date.day} $bulan ${date.year}";
                                                })(),
                                                style: const TextStyle(
                                                  fontWeight:
                                                    FontWeight.bold),
                                                ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Jumlah: ${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(double.tryParse(data['amount'].toString()) ?? 0)}',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          data['status'] == 'lunas'
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: data['status'] == 'lunas'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
