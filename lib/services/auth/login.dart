import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/config/api_config.dart';
import 'package:presensi_flutter_test/models/login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> login(LoginRequest loginRequest) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  final url = Uri.parse('${ApiConfig.BASEAPIURL}/api/login-student');

  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(loginRequest.toJson()));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data']['token'];
    await prefs.setString('token', data);
  } else {
    throw jsonDecode(response.body)['message'];
  }
}
