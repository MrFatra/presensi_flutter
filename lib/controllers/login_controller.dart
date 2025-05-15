import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/login_response_model.dart';
import '../views/home_page.dart';

class LoginController {
  static Future<void> login(
      BuildContext context, String idStudent, String password) async {
    try {
      final response = await http.post(
        Uri.parse('\${ApiConfig.apiBaseUrl}/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id_student": idStudent.trim(),
          "password": password.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = loginResponseModelFromJson(response.body);
        print("Login berhasil: \${data.student.fullname}");

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Login Gagal'),
            content: Text('NIS atau password salah.'),
          ),
        );
      }
    } catch (e) {
      print("Error: \$e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Terjadi Kesalahan'),
          content: Text('Tidak dapat terhubung ke server: \$e'),
        ),
      );
    }
  }
}
