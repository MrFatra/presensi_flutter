import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/config/api_config.dart';
import 'package:presensi_flutter_test/models/login_request.dart';

Future<String> login(LoginRequest loginRequest) async {
  final url = Uri.parse('${ApiConfig.BASEAPIURL}/api/login-student');

  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(loginRequest.toJson()));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['data']['token'];
  } else {
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    throw Exception('Login gagal: ${response.body}');
  }
}
