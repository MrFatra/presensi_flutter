import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';

class RiwayatSPPPage extends StatefulWidget {
  const RiwayatSPPPage({super.key});

  @override
  State<RiwayatSPPPage> createState() => _RiwayatSPPPageState();
}

class _RiwayatSPPPageState extends State<RiwayatSPPPage> {
  String selectedBulan = 'Januari';
  String selectedTahun = '2025';
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

  List<Map<String, dynamic>> riwayatSPP = [
    {'tanggal': 'Senin, 10 Januari 2025', 'status': false},
    {'tanggal': 'Senin, 10 Januari 2025', 'status': true},
    {'tanggal': 'Senin, 10 Januari 2025', 'status': true},
    {'tanggal': 'Senin, 10 Januari 2025', 'status': true},
    {'tanggal': 'Senin, 10 Januari 2025', 'status': true},
    {'tanggal': 'Senin, 10 Januari 2025', 'status': true},
    {'tanggal': 'Senin, 10 Januari 2025', 'status': true},
  ];

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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 16),
                    child: const Text(
                      'RIWAYAT PEMBAYARAN SPP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

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
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: riwayatSPP.length,
                      itemBuilder: (context, index) {
                        final data = riwayatSPP[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time),
                              const SizedBox(width: 8),
                              Text(data['tanggal']),
                              const Spacer(),
                              Icon(
                                data['status']
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    data['status'] ? Colors.green : Colors.red,
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
