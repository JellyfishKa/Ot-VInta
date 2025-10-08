import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/screens/request_details_screen.dart';
import '../widgets/request_list_item.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class RequestsScreen extends StatelessWidget {
  final List<RequestModel> requests;
  // --- ИЗМЕНЕНО: Добавлена карта для получения названий сервисов ---
  final Map<int, String> servicesMap;
  final Function(int) onDeleteRequest;

  const RequestsScreen({
    super.key,
    required this.requests,
    required this.servicesMap, // Карта обязательна
    required this.onDeleteRequest,
  });

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimens.padding_16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        // --- ИЗМЕНЕНО: Находим название сервиса по ID ---
        final serviceName = servicesMap[request.serviceId] ?? 'Неизвестный сервис';

        return Dismissible(
          key: Key(request.id.toString()),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            onDeleteRequest(request.id);
          },
          background: _buildDismissibleBackground(),
          child: RequestListItem(
            request: request,
            // --- ИЗМЕНЕНО: Передаем найденное имя в виджет ---
            serviceName: serviceName,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RequestDetailsScreen(
                    request: request,
                    // --- ИЗМЕНЕНО: Передаем имя и на экран деталей ---
                    serviceName: serviceName,
                  ),
                ),
              );
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppDimens.padding_12),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppDimens.radius_20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_20),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(Icons.delete_outline, color: AppColors.white),
          const SizedBox(width: AppDimens.padding_8),
          Text(
            'Удалить',
            style: AppTextStyles.buttonPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'У вас нет активных\nзаявок :(',
            style: AppTextStyles.h2, // Стиль покрупнее, как в макете
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.padding_24),
          ElevatedButton(
            onPressed: () {
              // --- ИЗМЕНЕНО: Просто закрываем экран "Мои заявки", возвращаясь на предыдущий ---
              Navigator.of(context).pop();
            },
            child: const Text('Вернуться назад'),
          ),
        ],
      ),
    );
  }
}