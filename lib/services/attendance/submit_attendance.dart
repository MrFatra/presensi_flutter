import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/config/api_config.dart';
import 'package:presensi_flutter_test/models/attendance_request.dart';
import 'package:presensi_flutter_test/models/attendance_response.dart';
import 'package:presensi_flutter_test/utils/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> attendanceNow({required bool isCheckIn}) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final locationData = await getLocation();
    double latitude = locationData.latitude!;
    double longitude = locationData.longitude!;

    debugPrint('latitude: $latitude');
    debugPrint('longitude: $longitude');

    int? getAttendanceId = prefs.getInt('attendance_id');

    debugPrint('attendance_id: $getAttendanceId');

    final request = AttendanceRequest(
      attendanceId: getAttendanceId,
      latitude: latitude,
      longitude: longitude,
      statusId: 1,
    );

    debugPrint('toJson: ${request.toJson()}');
    debugPrint('encoded body: ${jsonEncode(request.toJson())}');

    final url = Uri.parse(
      isCheckIn
          ? '${ApiConfig.BASEAPIURL}/api/student/attendance/check-in'
          : '${ApiConfig.BASEAPIURL}/api/student/attendance/check-out',
    );

    debugPrint('uri ${url.path}');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.get('token')}'
        },
        body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      debugPrint('success data: $decoded');
      final data = AttendanceResponse.fromJson(jsonDecode(response.body));
      debugPrint('data.message succcess: ${data.message}');
      if (isCheckIn) {
        await prefs.setInt('attendance_id', data.data!.id);
        return data.message;
      } else {
        await prefs.remove('attendance_id');
        return data.message;
      }
    } else {
      debugPrint('data.message error: ${jsonDecode(response.body)['message']}');
      throw jsonDecode(response.body)['message'];
    }
  } catch (err) {
    debugPrint('$err');
    rethrow;
  }
}
