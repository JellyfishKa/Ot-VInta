import 'package:flutter/material.dart';

// Этот класс будет хранить все стандартные размеры и отступы.
class AppDimens {
  AppDimens._(); // Запрещаем создавать экземпляры

  // Стандартные отступы (padding/margin), кратные 4 или 8
  static const double padding_4 = 4.0;
  static const double padding_8 = 8.0;
  static const double padding_12 = 12.0;
  static const double padding_16 = 16.0;
  static const double padding_20 = 20.0;
  static const double padding_24 = 24.0;
  static const double padding_32 = 32.0;

  // Стандартные радиусы скругления
  static const double radius_4 = 4.0;
  static const double radius_8 = 8.0;
  static const double radius_12 = 12.0;
  // Высота AppBar
  static double appBarHeight = kToolbarHeight;

  // Другие размеры (например, высота кнопок, иконок)
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 30.0;
  static const double radius_20 = 20.0;
  static const double iconSizeXLarge = 36.0;

}