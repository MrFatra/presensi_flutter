import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';


Future<List<dynamic>> getRapor(String token, String filter) async {
  try {
    final url = Uri.parse('${ApiConfig.BASEAPIURL}/api/student-acchievement');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'][filter];
    } else {
      throw Exception('Gagal ambil data rapor');
    }
  } catch (e) {
    throw Exception('Gagal ambil data rapor: $e');
  }
}