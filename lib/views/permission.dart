import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';
import 'package:presensi_flutter_test/widgets/permisions/form_permission.dart';
import 'package:presensi_flutter_test/widgets/profil_widget.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const FormPermission(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: 2)
    );
  }
}