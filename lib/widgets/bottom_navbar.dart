// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/utils/constant.dart';
import 'package:presensi_flutter_test/views/home_page.dart';
import 'package:presensi_flutter_test/views/profile_siswa.dart';
import 'package:presensi_flutter_test/views/rapor_page.dart';
import 'package:presensi_flutter_test/views/riwayatpeminjamanbuku.dart';
import 'package:presensi_flutter_test/views/riwayatspp.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const BottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedLabelStyle: AppTextStyles.small.copyWith(
        color: AppColors.primary,
      ),
      unselectedLabelStyle: AppTextStyles.small,
      onTap: (index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (index == 0)
                return  RiwayatPeminjamanBukuPage();
              else if (index == 1)
                return  RiwayatSPPPage();
              else if (index == 2)
                return  HomePage();
              else if (index == 3)
                return  RaporPage();
              else 
                return StudentProfilePage();
            },
          ),
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.history_edu_rounded,  color: Colors.blueAccent,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment,  color: Colors.blueAccent,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded,  color: Colors.blueAccent,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star, color: Colors.blueAccent,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded, color: Colors.blueAccent,),
          label: '',
        ),
      ],
    );
  }
}
