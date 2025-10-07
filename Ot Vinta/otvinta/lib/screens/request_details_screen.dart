import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';

class RequestDetailsScreen extends StatelessWidget {
  final RequestModel request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали заявки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          // Оборачиваем детали в Card для лучшего визуального отделения
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize.min позволяет Column занять минимально необходимое место
              mainAxisSize: MainAxisSize.min, 
              children: [
                Text(
                  request.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                const Divider(), // Визуальный разделитель
                const SizedBox(height: 16),

                // Используем вспомогательный виджет для отображения полей
                _buildDetailRow('ID Заявки:', request.id.toString()),
                const SizedBox(height: 12),
                _buildDetailRow('Дата подачи:', request.date),
                const SizedBox(height: 12),
                
                // Отображение статуса с цветовой индикацией
                _buildStatusRow('Статус:', request.status),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Вспомогательный виджет для отображения строки "Метка: Значение"
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  /// Виджет для отображения статуса в виде стилизованного "чипа"
  Widget _buildStatusRow(String label, RequestStatus status) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
        const SizedBox(width: 8),
        Chip(
          label: Text(
            status.displayName,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: _getStatusColor(status),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        ),
      ],
    );
  }

  /// Возвращает цвет в зависимости от статуса заявки
  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.approved:
        return Colors.green;
      case RequestStatus.inProgress:
        return Colors.orange;
      case RequestStatus.rejected:
        return Colors.red;
      case RequestStatus.pending:
        return Colors.blue;
    }
  }
}