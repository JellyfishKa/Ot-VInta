import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Мы создадим этот файл на следующем шаге

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otvinta Corporate', // Изменили название
      debugShowCheckedModeBanner: false, // Убираем отладочную ленту
      theme: ThemeData(
        primarySwatch: Colors.blue, // Вы можете выбрать любой основной цвет
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(), // Указываем наш будущий главный экран
    );
  }
}