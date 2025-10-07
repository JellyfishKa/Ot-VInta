import 'package:flutter/material.dart';
import '../models/service_model.dart';
class CreateRequestScreen extends StatelessWidget {
  final ServiceModel service;

  const CreateRequestScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подтверждение заявки'),
        // Убираем тень под AppBar для более чистого вида
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        // Увеличиваем отступы для лучшей центровки
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // Центрируем контент по вертикали и растягиваем по горизонтали
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // <-- ИЗМЕНЕНО: Используем статическую иконку вместо service.icon
            Icon(
              Icons.article_outlined, 
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),
            const Text(
              'Вы уверены, что хотите подать заявку на услугу:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            // Отображаем название услуги, которое пришло с сервера
            Text(
              service.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            // Кнопка подтверждения
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
              // При нажатии возвращаем `true` на предыдущий экран
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Подать заявку'),
            ),
            const SizedBox(height: 12),
            // Кнопка отмены для лучшего UX
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
          ],
        ),
      ),
    );
  }
}