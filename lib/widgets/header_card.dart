import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/utils/constant.dart';

class HeaderCard extends StatelessWidget {
  final String title;

  const HeaderCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: AppTextSizes.heading2,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
