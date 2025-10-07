import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 1. Импортируем пакет dotenv
import 'screens/home_screen.dart'; 

// 2. Превращаем main в асинхронную функцию Future<void>
Future<void> main() async {
  // 3. Гарантируем, что все биндинги Flutter инициализированы
  // Эта строка обязательна для асинхронных операций в main до runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // 4. Загружаем переменные из файла .env в память.
  // 'await' останавливает выполнение, пока файл не будет загружен.
  await dotenv.load(fileName: ".env");
  
  // 5. Только после успешной загрузки .env запускаем приложение
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
        // Рекомендуется использовать colorSchemeSeed вместо primarySwatch
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}