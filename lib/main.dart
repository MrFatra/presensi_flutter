import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/views/home_page.dart';
import 'package:presensi_flutter_test/views/login_page.dart';
import 'package:presensi_flutter_test/views/profile_siswa.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
