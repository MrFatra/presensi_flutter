import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';
import 'package:presensi_flutter_test/widgets/profile/profile_detail.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade600,
        bottomNavigationBar: BottomNavbar(currentIndex: 4),
        body: SafeArea(
          child: Column(
            children: [
              const ProfileHeader(),
              const SizedBox(height: 10),
              const ProfileDetails(),
              
            ],
          ),
        ));
  }
}
