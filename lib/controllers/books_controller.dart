import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/models/books_response_model.dart';
import 'dart:convert';

class BooksController {
  static Future<void> books(
    BuildContext context,
    String token, 
  ) async {
    try {
      final response  = await http.get(
        Uri.parse('\${ApiConfig.apiBaseUrl}/api/api/book-loan'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = BooksResponseModel.fromJson(jsonDecode(response.body));
      } else {
       showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Get data Gagal'),
            content: Text('Silahkan Kembali lagi nanti.'),
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
