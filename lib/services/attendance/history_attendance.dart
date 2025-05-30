import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/config/api_config.dart';
import 'package:presensi_flutter_test/models/attendance_history_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AttendanceHistoryResponse> getAttendanceHistory(bool checkIn) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final url = Uri.parse(
    '${ApiConfig.BASEAPIURL}/api/student/attendance/histories${checkIn == false ? '?type=keluar' : ''}',
  );

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${prefs.get('token')}'
  });

  if (response.statusCode == 200) {
    return AttendanceHistoryResponse.fromJson(jsonDecode(response.body));
  } else {
    throw jsonDecode(response.body)['message'];
  }
}
