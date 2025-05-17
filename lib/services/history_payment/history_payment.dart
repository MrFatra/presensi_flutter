import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../config/api_config.dart';

Future<List<dynamic>> getHistoryPayment(String token) async {
  try {
    final url = Uri.parse('${ApiConfig.BASEAPIURL}/api/payments-history');
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
      return data['data']
          ['history-payments'];
    } else {
      throw Exception('Gagal ambil data history payment');
    }
  } catch (e) {
    print("Gagal ambil data history payment: $e");
    throw Exception('Gagal ambil data history payment: $e');
  }
}
