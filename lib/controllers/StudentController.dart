import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response_model.dart'; // pastikan model sesuai

class StudentController {
  static Future<Student?> getStudentById(String idStudent) async {
    try {
      final response = await http.get(
        Uri.parse('\${ApiConfig.apiBaseUrl}/api/students/\$idStudent'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Student.fromJson(json.decode(response.body));
      } else {
        print('Failed to load student');
        return null;
      }
    } catch (e) {
      print("Error fetching student: \$e");
      return null;
    }
  }
}
