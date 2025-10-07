import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/screens/request_details_screen.dart';

class RequestsScreen extends StatelessWidget {
  final List<RequestModel> requests;
  final Function(String) onDeleteRequest; // Принимаем функцию удаления

  const RequestsScreen({
    super.key,
    required this.requests,
    required this.onDeleteRequest,
  });

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        child: Text(
          "У вас пока нет заявок",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
       
        return Dismissible(
          // 'key' обязателен. Он помогает Flutter понять, какой именно элемент удаляется из списка.
          key: Key(request.id.toString()),

          // Направление свайпа: от начала к концу (слева направо).
          direction: DismissDirection.startToEnd,

          // Функция, которая вызывается, когда элемент полностью "смахнули".
          onDismissed: (direction) {
            // Вызываем функцию обратного вызова из HomeScreen, передавая ID заявки.
            onDeleteRequest(request.id.toString());
          },

          // 'background' — это виджет, который появляется ПОД элементом во время свайпа.
          background: Container(
            color: Colors.red[700],
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Row(
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Удалить',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 'child' — это наш основной виджет, который мы смахиваем.
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: InkWell(
              onTap: () {
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
          ),
        );
      },
    );
  }

  /// Возвращает цвет в зависимости от статуса заявки.
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