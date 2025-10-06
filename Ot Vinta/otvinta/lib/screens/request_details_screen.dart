// lib/screens/request_details_screen.dart

import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';

class RequestDetailsScreen extends StatelessWidget {
  final RequestModel request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали заявки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('ID Заявки:', request.id),
            const SizedBox(height: 8),
            _buildDetailRow('Дата подачи:', request.date),
            const SizedBox(height: 8),
            _buildDetailRow('Статус:', request.status.displayName),
            // Сюда можно будет в будущем добавить любую другую информацию
          ],
        ),
      ),
    );
  }

  // Вспомогательный виджет для отображения строки "Метка: Значение"
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}