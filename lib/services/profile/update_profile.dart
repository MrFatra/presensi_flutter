import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_flutter_test/config/api_config.dart';
import 'package:presensi_flutter_test/models/student_profile_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> updateProfile(StudentProfileRequest request) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse('${ApiConfig.BASEAPIURL}/api/profile-update');

    final httpRequest = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer ${prefs.getString('token')}'
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(request
          .toJson()
          .map((key, value) => MapEntry(key, value.toString())));

    if (request.photo != null) {
      httpRequest.files.add(await http.MultipartFile.fromPath(
        'photo',
        request.photo!.path,
      ));
    }

    final response = await httpRequest.send();
    final responseBody = await response.stream.bytesToString();
    final data = jsonDecode(responseBody);

    if (response.statusCode == 200) {
      debugPrint(data['message']);
      return data['message'];
    } else {
      debugPrint(data['message']);
      return data['message'];
    }
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}
