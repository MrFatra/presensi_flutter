import 'package:flutter/material.dart';

class RiwayatSPPPage extends StatefulWidget {
  const RiwayatSPPPage({super.key});

  @override
  State<RiwayatSPPPage> createState() => _RiwayatSPPPageState();
}

class _RiwayatSPPPageState extends State<RiwayatSPPPage> {
  String selectedBulan = 'Januari';
  String selectedTahun = '2025';
  List<String> bulanList = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
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
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header profil
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/images/gambar.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nama Siswa',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Nomor Induk Siswa - KELAS',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Title Riwayat SPP
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
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
                        return DropdownMenuItem(value: bulan, child: Text(bulan));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedBulan = val!;
                        });
                      },
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
                      items: tahunList.map((tahun) {
                        return DropdownMenuItem(value: tahun, child: Text(tahun));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedTahun = val!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                          data['status'] ? Icons.check_circle : Icons.cancel,
                          color: data['status'] ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
