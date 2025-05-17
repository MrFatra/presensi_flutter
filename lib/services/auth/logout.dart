
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/config/api_config.dart';
import 'package:presensi_flutter_test/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

  Future<void> logout(dynamic context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final url = Uri.parse('${ApiConfig.BASEAPIURL}/api/logout-student');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get('token')}',
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('token');

        // Tampilkan dialog logout berhasil
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Anda berhasil logout.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); // Arahkan ke login
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('error ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logout gagal. Silakan coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }