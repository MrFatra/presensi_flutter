import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/models/student_profile_response.dart';
import 'package:presensi_flutter_test/services/profile/get_profile.dart';
import 'package:presensi_flutter_test/utils/date_formater.dart';
import 'package:presensi_flutter_test/views/editprofilesiswa.dart';
import 'package:presensi_flutter_test/widgets/header_card.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  StudentProfileResponse? student;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final profileData = await getProfile();
      setState(() {
        student = profileData;
      });
    } catch (e) {
      setState(() {
        student = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Title
            HeaderCard(title: "Profil Pelajar"),
            Center(
              child: student?.student.photo != null &&
                      student!.student.photo!.isNotEmpty
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('http://10.0.2.2:8000/storage/${student!.student.photo!}'),
                      backgroundColor: Colors.grey[200],
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
            ),
            Text(student?.student.fullname ?? ''),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (student != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              'NIS',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(': '),
                          Expanded(
                            child: Text(student!.student.idStudent ?? ''),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              'Kelas',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(': '),
                          Expanded(
                            child: Text(student!.student.studentClass ?? ''),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              'TTL',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(': '),
                          Expanded(
                            child: Text(student!.student.birthPlace != null &&
                                    student!.student.birthDate != null
                                ? '${student!.student.birthPlace} / ${formatTanggal(student!.student.birthDate)}'
                                : ''),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              'No Hp',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(': '),
                          Expanded(
                            child: Text(student!.student.parentPhonecell ?? ''),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              'Gender',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(': '),
                          Expanded(
                            child: Text(student!.student.gender ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileSiswaPage(
                                      fullName: student!.student.fullname,
                                      birthDate: student!.student.birthDate,
                                      birthPlace: student!.student.birthPlace,
                                      phoneNumber:
                                          student!.student.parentPhonecell,
                                      photo: student!.student.photo ?? '-',
                                    )));
                      },
                      child: const Text(
                        'EDIT PROFILE',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
