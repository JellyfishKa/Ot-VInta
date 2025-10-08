import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart'; 
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otvinta Corporate',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        useMaterial3: true,
        
        // 1. Цветовая схема
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,

        // 2. Стили текста (будут применяться по умолчанию ко всем Text)
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.h1,    // Самый большой заголовок
          headlineMedium: AppTextStyles.h2,   // Заголовки поменьше
          titleMedium: AppTextStyles.h3,      // Заголовки карточек
          bodyMedium: AppTextStyles.body,       // Основной текст
          labelLarge: AppTextStyles.buttonPrimary, // Текст на кнопках
        ),
        
        // 3. Стили для AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white, // AppBar теперь белый
          foregroundColor: AppColors.textPrimary, // Текст и иконки на нем - черные
          titleTextStyle: AppTextStyles.h2,
          elevation: 1, // Небольшая тень
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        
        // 4. Стили для кнопок ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            textStyle: AppTextStyles.buttonPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Стандартное скругление
            ),
            elevation: 0, // Без тени
          ),
        ),
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}