import 'dart:io';

class StudentProfileRequest {
  final String fullName;
  final String parentPhoneCell;
  final File? photo;
  final String birthDate;
  final String birthPlace;
  final String? password;

  StudentProfileRequest({
    required this.fullName,
    required this.parentPhoneCell,
    required this.birthDate,
    required this.birthPlace,
    this.photo,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'fullname': fullName,
        'parent_phonecell': parentPhoneCell,
        'birth_place': birthPlace,
        'birth_date': birthDate,
        if (password != null && password!.isNotEmpty) 'password': password!,
      };
}
