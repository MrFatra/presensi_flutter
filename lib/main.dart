import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/views/home_page.dart';
import 'package:presensi_flutter_test/views/login_page.dart';
import 'package:presensi_flutter_test/views/permission.dart';
import 'package:presensi_flutter_test/views/profile_siswa.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:presensi_flutter_test/views/riwayatpeminjamanbuku.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RiwayatPeminjamanBukuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
