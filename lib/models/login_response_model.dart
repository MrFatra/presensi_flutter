// To parse this JSON data, do:
// final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String message;
  Student student;

  LoginResponseModel({
    required this.message,
    required this.student,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        message: json["message"],
        student: Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "student": student.toJson(),
      };
}

class Student {
  String idStudent;
  String fullname;
  int classId;
  String parentPhonecell;
  dynamic photo;
  DateTime createdAt;
  DateTime updatedAt;
  String birthPlace;
  DateTime birthDate;
  String gender;
  int academicYearId;
  int semesterId;

  Student({
    required this.idStudent,
    required this.fullname,
    required this.classId,
    required this.parentPhonecell,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.birthPlace,
    required this.birthDate,
    required this.gender,
    required this.academicYearId,
    required this.semesterId,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        idStudent: json["id_student"],
        fullname: json["fullname"],
        classId: json["class_id"],
        parentPhonecell: json["parent_phonecell"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        birthPlace: json["birth_place"],
        birthDate: DateTime.parse(json["birth_date"]),
        gender: json["gender"],
        academicYearId: json["academic_year_id"],
        semesterId: json["semester_id"],
      );

  Map<String, dynamic> toJson() => {
        "id_student": idStudent,
        "fullname": fullname,
        "class_id": classId,
        "parent_phonecell": parentPhonecell,
        "photo": photo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "birth_place": birthPlace,
        "birth_date": birthDate.toIso8601String(),
        "gender": gender,
        "academic_year_id": academicYearId,
        "semester_id": semesterId,
      };
}
