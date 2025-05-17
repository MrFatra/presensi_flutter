import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/models/student_profile_response.dart';
import 'package:presensi_flutter_test/services/auth/logout.dart';
import 'package:presensi_flutter_test/services/profile/get_profile.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});
  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  StudentProfileResponse? student;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: student?.student.photo != null
            ? NetworkImage('http://10.0.2.2:8000/storage/${student!.student.photo!}')
            : null,
        backgroundColor: Colors.white24,
      ),
      title: Text(
        student?.student.fullname ?? '-',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${student?.student.idStudent ?? '-'} - ${student?.student.studentClass ?? '-'}',
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () {
          logout(context);
        },
        tooltip: 'Logout',
      ),
    );
  }
}
