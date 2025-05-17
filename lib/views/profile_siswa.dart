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
        bottomNavigationBar: BottomNavbar(currentIndex: 4),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const ProfileHeader(),
                  const SizedBox(height: 10),
                  const ProfileDetails(),
                ],
              ),
            )
          ],
        ));
  }
}
