import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_flutter_test/models/attendance_history_response.dart';
import 'package:presensi_flutter_test/services/attendance/history_attendance.dart';
import 'package:presensi_flutter_test/models/attendance_now_response.dart';
import 'package:presensi_flutter_test/services/attendance/now_attendance.dart';
import 'package:presensi_flutter_test/services/attendance/submit_attendance.dart';
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
  AttendanceHistoryResponse? histories;
  bool isLoading = true;
  bool isCheckIn = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final value = await getAttendanceNow();
      await getAttendanceHistoryData();

      setState(() {
        attendanceData = value;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Gagal mengambil data absensi: $e');
    }
  }

  Future<void> getAttendanceHistoryData() async {
    try {
      final historiesData = await getAttendanceHistory(isCheckIn);
      setState(() {
        histories = historiesData;
      });
    } catch (e) {
      print('Gagal mengambil riwayat absensi: $e');
    }
  }

  void handleCheckIn() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap tunggu...')),
      );
      final response = await attendanceNow(isCheckIn: true);
      final data = await getAttendanceNow();
      await getAttendanceHistoryData();
      setState(() {
        attendanceData = data;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void handleCheckOut() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap tunggu...')),
      );
      final response = await attendanceNow(isCheckIn: false);
      final data = await getAttendanceNow();
      await getAttendanceHistoryData();
      setState(() {
        attendanceData = data;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(currentIndex: 2),
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
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  ProfileHeader(),
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

    final checkIn = attendanceData?.checkInTime != null
        ? DateFormat('HH:mm')
            .format(DateFormat('HH:mm:ss').parse(attendanceData!.checkInTime!))
        : '-';

    final checkOut = attendanceData?.checkOutTime != null
        ? DateFormat('HH:mm')
            .format(DateFormat('HH:mm:ss').parse(attendanceData!.checkOutTime!))
        : '-';

    final status = attendanceData!.status ?? '-';

    final bool isCheckedIn = checkIn != '-';
    final bool isCheckedOut = checkOut != '-';
    final bool isPresent = status == 'Hadir';
    final bool isPermission = status == 'Izin';

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
                onPressed: (!isCheckedIn && !isPresent && !isPermission)
                    ? handleCheckIn
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                child: const Text('MASUK'),
              ),
              ElevatedButton(
                onPressed: (isCheckedIn && !isCheckedOut && !isPermission)
                    ? handleCheckOut
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                child: const Text('KELUAR'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: (!isCheckedIn &&
                    !isCheckedOut &&
                    !isPermission &&
                    !isPresent)
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PermissionPage()),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('IZIN'),
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatAbsensi() {
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
                  isCheckIn
                      ? 'Riwayat Absensi Masuk'
                      : 'Riwayat Absensi Keluar',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Switch(
                  value: isCheckIn,
                  onChanged: (val) async {
                    setState(() {
                      isCheckIn = val;
                    });
                    await getAttendanceHistoryData();
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: histories == null
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                : histories!.data.isEmpty
                    ? const Center(
                        child: Text('Tidak ada data.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: histories!.data.length,
                        itemBuilder: (context, index) {
                          final item = histories!.data[index];
                          return _buildAbsensiItem(
                              item.attendanceDate, item.status);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbsensiItem(String date, String status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Text(DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                .format(DateTime.tryParse(date)!)),
            const Spacer(),
            Text(
              status,
              style: TextStyle(
                color: status == 'Hadir'
                    ? Colors.green
                    : status == 'Izin'
                        ? Colors.orange
                        : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
