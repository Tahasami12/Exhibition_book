import 'package:flutter/material.dart';
import 'app_colors.dart';

class Styles {

  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    color: AppColors.textSecondary,
  );

  static const TextStyle small = TextStyle(
    fontSize: 14,
    fontFamily: 'Roboto',
    color: AppColors.grey500,
  );
}