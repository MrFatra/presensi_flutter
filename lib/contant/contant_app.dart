// constants.dart
import 'package:flutter/material.dart';

class AppColors {
  static const present = Colors.green;
  static const late = Colors.orange;
  static const permission = Colors.blue;
}

class AppPadding {
  static const pagePadding = EdgeInsets.all(16.0);
  static const cardPadding = EdgeInsets.all(16.0);
  static const statusBadgePadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
}

class AppSizes {
  static const small = 4.0;
  static const smedium = 8.0;
  static const medium = 16.0;
  static const large = 24.0;
  static const xLarge = 32.0;
}

class AppTextStyles {
  static const TextStyle headerTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headerSubtitle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
  );

  static const TextStyle confirmationText = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    color: Colors.green,
  );
}
