import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../config/api_config.dart';


Future<List<dynamic>> getBooks(String token) async {
  final url = Uri.parse('${ApiConfig.BASEAPIURL}/api/book-loan');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    return data['data']['books']; // pastikan sesuai dengan struktur respons kamu
  } else {
    throw Exception('Gagal ambil data buku');
  }
}
