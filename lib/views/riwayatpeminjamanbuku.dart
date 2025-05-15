import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';

class RiwayatPeminjamanBukuPage extends StatefulWidget {
  const RiwayatPeminjamanBukuPage({super.key});

  @override
  State<RiwayatPeminjamanBukuPage> createState() =>
      _RiwayatPeminjamanBukuPageState();
}

class _RiwayatPeminjamanBukuPageState extends State<RiwayatPeminjamanBukuPage> {
  List<Map<String, dynamic>> riwayatBuku = [
    {'judul': 'Matematika Dasar', 'nomor': '001', 'tanggal': '01 Januari 2025'},
    {'judul': 'Fisika Lanjut', 'nomor': '002', 'tanggal': '02 Januari 2025'},
    {'judul': 'Kimia Umum', 'nomor': '003', 'tanggal': '03 Januari 2025'},
    {'judul': 'Biologi Modern', 'nomor': '004', 'tanggal': '04 Januari 2025'},
    {'judul': 'Sejarah Dunia', 'nomor': '005', 'tanggal': '05 Januari 2025'},
    {'judul': 'Bahasa Indonesia', 'nomor': '006', 'tanggal': '06 Januari 2025'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      bottomNavigationBar: BottomNavbar(currentIndex: 0),
      body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                 borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Title Riwayat Peminjaman Buku
                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'RIWAYAT PEMINJAMAN BUKU',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // List riwayat peminjaman buku
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: riwayatBuku.length,
                      itemBuilder: (context, index) {
                        final data = riwayatBuku[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.menu_book, size: 30),
                              const SizedBox(height: 8),
                              Text(
                                data['judul'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text('No: ${data['nomor']}',
                                  style: const TextStyle(fontSize: 12)),
                              Text('Tgl: ${data['tanggal']}',
                                  style: const TextStyle(fontSize: 12)),
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
