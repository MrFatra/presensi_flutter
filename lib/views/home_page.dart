import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/views/permission.dart';
import 'package:presensi_flutter_test/views/profile_siswa.dart';
import 'package:presensi_flutter_test/views/riwayatspp.dart';
import 'package:presensi_flutter_test/views/riwayatpeminjamanbuku.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMasukHistory = true;
  int _currentIndex = 1; // Home index di tengah (2)

  // List semua page tujuan
  final List<Widget> _pages = [
    const RiwayatPeminjamanBukuPage(),
    const RiwayatSPPPage(),
    const HomePage(), // HomePage sendiri
    const HomePage(), // Placeholder untuk Notifikasi
    const HomePage(), // Placeholder untuk Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavbar(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Card Absensi
              _buildAbsensiCard(),

              // Riwayat Absensi
              _buildRiwayatAbsensi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Nomor Induk Siswa - KELAS',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'ABSENSI HARI INI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('HARI / TANGGAL'),
          const SizedBox(height: 12),
          const Text(
            '08:17',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('MASUK'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text('KELUAR'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PermissionPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              foregroundColor: Colors.black,
            ),
            child: const Text('IZIN'),
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatAbsensi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                showMasukHistory
                    ? 'Riwayat Absensi Masuk'
                    : 'Riwayat Absensi Keluar',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Switch(
                value: showMasukHistory,
                onChanged: (val) {
                  setState(() {
                    showMasukHistory = val;
                  });
                },
              ),
            ],
          ),
          Column(
            children: [
              _buildAbsensiItem('Hari, Tanggal', 'Hadir', Colors.green),
              _buildAbsensiItem('Hari, Tanggal', 'Izin', Colors.orange),
              _buildAbsensiItem('Hari, Tanggal', 'Hadir', Colors.green),
              _buildAbsensiItem('Hari, Tanggal', 'Hadir', Colors.green),
              _buildAbsensiItem('Hari, Tanggal', 'Terlambat', Colors.red),
              _buildAbsensiItem('Hari, Tanggal', 'Hadir', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiItem(String date, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(date),
          const Spacer(),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
