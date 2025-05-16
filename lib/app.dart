import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:presensi_flutter_test/views/login_page.dart';
import 'package:presensi_flutter_test/views/home_page.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialPage = const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    setState(() {
      _initialPage = token != null ? const HomePage() : const LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _initialPage,
      debugShowCheckedModeBanner: false,
    );
  }
}
