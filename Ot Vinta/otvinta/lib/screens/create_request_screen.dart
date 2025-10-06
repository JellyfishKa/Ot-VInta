import 'package:flutter/material.dart';
import '../models/service_model.dart'; // Нам нужна модель сервиса

class CreateRequestScreen extends StatelessWidget {
  // Этот экран будет принимать информацию о выбранной услуге
  final ServiceModel service;

  const CreateRequestScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подтверждение заявки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Вы выбрали услугу:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: Icon(service.icon, color: Theme.of(context).primaryColor),
                title: Text(service.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const Spacer(), // Занимает всё свободное пространство, прижимая кнопку к низу
            ElevatedButton(
              
              onPressed: () {
                // Возвращаем результат (true) на предыдущий экран
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Подать заявку'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}