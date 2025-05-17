import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/utils/constant.dart';

class RaporToggle extends StatelessWidget {
  final String selectedData;
  final Function(String) onTap;

  const RaporToggle({
    required this.selectedData,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => onTap('Data Rapor'),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                selectedData == 'Data Rapor' ? AppColors.info : Colors.grey,
          ),
          child: const Text('Data Rapor', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () => onTap('Data Prestasi'),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                selectedData == 'Data Prestasi' ? AppColors.info : Colors.grey,
          ),
          child: const Text('Data Prestasi', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
