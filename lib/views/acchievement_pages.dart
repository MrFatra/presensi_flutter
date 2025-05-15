import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/widgets/bottom_navbar.dart';

class AcchievementPage extends StatelessWidget {
  const AcchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(child: Text("Hallo")),
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: 3),
    );
  }
}
