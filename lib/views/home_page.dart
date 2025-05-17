import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_flutter_test/models/attendance_now_response.dart';
import 'package:presensi_flutter_test/models/student_profile_response.dart';
import 'package:presensi_flutter_test/services/attendance/now_attendance.dart';
import 'package:presensi_flutter_test/services/profile/get_profile.dart';
import 'package:presensi_flutter_test/views/permission.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AttendanceNowResponse? attendanceData;
  StudentProfileResponse? profile;
  bool isLoading = true;
  bool isHistory = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final value = await getAttendanceNow();
      final profileData = await getProfile();
      setState(() {
        attendanceData = value;
        profile = profileData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Gagal mengambil data absensi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 2),
      body: Stack(
        children: [
          // Blue Ellipse Background
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
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  profile == null
                      ? CircularProgressIndicator()
                      : ProfileHeader(),
                  _buildAbsensiCard(),
                  const SizedBox(height: 12),
                  Expanded(child: _buildRiwayatAbsensi()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiCard() {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (attendanceData == null) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text('Tidak ada data absensi untuk hari ini.'),
      );
    }

    final checkIn = attendanceData!.checkInTime != null
        ? DateFormat('HH:mm').format(attendanceData!.checkInTime!)
        : '-';

    final checkOut = attendanceData!.checkOutTime != null
        ? DateFormat('HH:mm').format(attendanceData!.checkOutTime!)
        : '-';

    final status = attendanceData!.status ?? '-';

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
          Text(
              DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now())),
          const SizedBox(height: 12),
          Text(
            'Masuk: $checkIn',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Keluar: $checkOut',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: $status',
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: status == 'Hadir' && checkIn != '-' ? null : () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('MASUK'),
              ),
              ElevatedButton(
                onPressed: status == 'Hadir' && checkOut != '-' ? null : () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('KELUAR'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: status == 'Izin'
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PermissionPage()),
                    );
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
    final List<Map<String, Object>> dummyData = [
      {'date': 'Senin, 13 Mei 2025', 'status': 'Hadir', 'color': Colors.green},
      {'date': 'Selasa, 14 Mei 2025', 'status': 'Izin', 'color': Colors.orange},
      {'date': 'Rabu, 15 Mei 2025', 'status': 'Hadir', 'color': Colors.green},
      {'date': 'Kamis, 16 Mei 2025', 'status': 'Hadir', 'color': Colors.green},
      {'date': 'Jumat, 17 Mei 2025', 'status': 'Hadir', 'color': Colors.green},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  isHistory
                      ? 'Riwayat Absensi Masuk'
                      : 'Riwayat Absensi Keluar',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Switch(
                  value: isHistory,
                  onChanged: (val) {
                    setState(() {
                      isHistory = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: dummyData.length,
              itemBuilder: (context, index) {
                final item = dummyData[index];
                return _buildAbsensiItem(item['date']! as String,
                    item['status']! as String, item['color'] as Color);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiItem(String date, String status, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
      ),
    );
  }
}
