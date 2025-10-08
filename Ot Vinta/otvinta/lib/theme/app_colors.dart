import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Основные цвета
  static const Color primary = Color(0xFF5B79F7); // Синий для кнопок
  static const Color background = Color(0xFFC8D1E0); // Фон
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Оттенки серого
  static const Color divider = Color(0xFFD9D9D9); // Разделители
  
  // Цвета текста
  static const Color textPrimary = Color(0xFF000000); // Для заголовков H1, H2
  static const Color textBody = Color(0xFF212121); // Для основного текста
  static const Color textSecondary = Color(0xFF595959); // Для надписи "Назад"
  
  // Цвета для статусов
  static const Color statusInProgressBg = Color(0xFFB9F8F3);
  static const Color statusInProgressText = Color(0xFF3BAAA2);
  
  static const Color statusPendingBg = Color(0xFFD6C1E9);
  static const Color statusPendingText = Color(0xFF8E52C5);

  static const Color statusApprovedBg = Color(0xFF22C77E);
  // Для Одобрено/Отклонено цвет текста белый
  
  static const Color statusRejectedBg = Color(0xFFFF5F64);

  // Системные цвета
  // (Пока используем цвета статусов, можно заменить на отдельные)
  static const Color success = Color(0xFF22C77E);
  static const Color error = Color(0xFFFF5F64);
}