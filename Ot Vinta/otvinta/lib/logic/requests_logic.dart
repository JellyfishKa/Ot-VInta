import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/services/api_service.dart';
import 'package:otvinta/theme/app_colors.dart';

class RequestsLogic {
  final ApiService _apiService = ApiService();
  List<RequestModel> requests = [];
  bool isLoading = true;

  Future<void> loadRequests(Function(String) onError, VoidCallback onDone) async {
    isLoading = true;
    onDone();
    try {
      requests = await _apiService.fetchRequests();
    } catch (e) {
      onError('Ошибка загрузки заявок: $e');
    } finally {
      isLoading = false;
      onDone();
    }
  }

  Future<void> confirmAndDeleteRequest({
    required BuildContext context,
    required int id,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final bool? isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение'),
          content: const Text('Вы уверены, что хотите удалить заявку?'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Отмена')),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), 
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Удалить')
            ),
          ],
        );
      },
    );

    if (isConfirmed == true) {
      final requestToRemove = requests.firstWhere((req) => req.id == id);
      final index = requests.indexOf(requestToRemove);
      requests.removeAt(index);
      onSuccess();

      try {
        await _apiService.deleteRequest(id.toString());
      } catch (e) {
        requests.insert(index, requestToRemove);
        onError('Ошибка удаления: $e');
        onSuccess();
      }
    }
  }
}