import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/screens/request_details_screen.dart';
import '../widgets/request_list_item.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class RequestsScreen extends StatelessWidget {
  final List<RequestModel> requests;
  final Function(int) onDeleteRequest; // ID теперь int

  const RequestsScreen({
    super.key,
    required this.requests,
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
       
        // Оборачиваем нашу красивую карточку в Dismissible
        return Dismissible(
          key: Key(request.id.toString()),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            // Вызываем callback, передавая числовой ID
            onDeleteRequest(request.id);
          },
          // Фон при свайпе (теперь тоже стилизованный)
          background: _buildDismissibleBackground(),
          child: RequestListItem(
            request: request,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  // Передаем весь объект request на экран деталей
                  builder: (context) => RequestDetailsScreen(request: request),
                ),
              );
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppDimens.padding_12),
    );
  }

  // Виджет для фона при удалении свайпом
  Widget _buildDismissibleBackground() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.error, // Используем цвет ошибки из нашей палитры
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
            // Используем стиль для кнопок, так как он подходит по цвету и насыщенности
            style: AppTextStyles.buttonPrimary,
          ),
        ],
      ),
    );
  }

  // Виджет для пустого состояния, как в макете
  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.padding_24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Растягиваем кнопку на всю ширину
        children: [
          Text(
            'У вас нет активных заявок :(',
            style: AppTextStyles.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.padding_24),
          ElevatedButton(
            onPressed: () {
              // TODO: Обсудить с командой, какое действие здесь должно быть.
              // Возможно, переход на экран "Сервисы" для создания новой заявки.
            },
            child: const Text('Вернуться назад'),
          ),
        ],
      ),
    );
  }
}