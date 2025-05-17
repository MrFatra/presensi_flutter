class StudentProfileResponse {
  final bool status;
  final String message;
  final Student student;

  StudentProfileResponse({
    required this.status,
    required this.message,
    required this.student,
  });

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) {
    return StudentProfileResponse(
      status: json['status'],
      message: json['message'],
      student: Student.fromJson(json['data']['student']),
    );
  }
}

class Student {
  final String idStudent;
  final String fullname;
  final String parentPhonecell;
  final String? photo;
  final String birthPlace;
  final String birthDate;
  final String gender;
  final String academicYear;
  final String semester;
  final String studentClass;

  Student({
    required this.idStudent,
    required this.fullname,
    required this.parentPhonecell,
    required this.birthPlace,
    required this.birthDate,
    required this.gender,
    required this.academicYear,
    required this.semester,
    required this.studentClass,
    this.photo,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      idStudent: json['id_student'],
      fullname: json['fullname'],
      parentPhonecell: json['parent_phonecell'],
      birthPlace: json['birth_place'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      academicYear: json['academic_year'],
      semester: json['semester'],
      studentClass: json['student_class'],
      photo: json['photo'],
    );
  }
}
