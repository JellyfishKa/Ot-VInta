import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/screens/request_details_screen.dart'; // <-- Добавлен импорт

class RequestsScreen extends StatelessWidget {
  final List<RequestModel> requests;

  const RequestsScreen({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(child: Text("У вас пока нет заявок"));
    }
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: InkWell( // <-- Оборачиваем ListTile в InkWell для эффекта нажатия
            onTap: () {
              // Действие при нажатии: навигация на экран деталей
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RequestDetailsScreen(request: request),
                ),
              );
            },
            child: ListTile(
              title: Text(request.title),
              subtitle: Text('Дата: ${request.date}'),
              trailing: Text(
                request.status.displayName,
                style: TextStyle(
                  color: _getStatusColor(request.status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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