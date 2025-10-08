import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // H1: Для главных заголовков экранов
  static TextStyle get h1 => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold, // Bold = w700
    color: AppColors.textPrimary,
  );

  // H2: Для заголовков поменьше
  static TextStyle get h2 => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold, // Bold = w700
    color: AppColors.textPrimary,
  );

  // H3: Для заголовков карточек
  static TextStyle get h3 => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600, // Semi Bold = w600
    color: AppColors.textPrimary,
  );

  // Body: Для основного текста
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium = w500
    color: AppColors.textBody,
  );

  // Стиль для основной кнопки (с белым текстом)
  static TextStyle get buttonPrimary => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // Стиль для вторичной кнопки (с синим текстом)
  static TextStyle get buttonSecondary => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  
  // Стиль для кнопки "Назад"
  static TextStyle get buttonBack => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium = w500
    color: AppColors.textSecondary,
  );

  // Стиль для текста у логотипа
  static TextStyle get logo => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}