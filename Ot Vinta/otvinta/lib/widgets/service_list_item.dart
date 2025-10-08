// lib/widgets/service_list_item.dart - ГОТОВИМ ПОД ДИЗАЙН

import 'package:flutter/material.dart';
import '../models/service_model.dart';
// --- ИЗМЕНЕНИЕ: Импортируем наши dimens и стили ---
import '../theme/app_dimens.dart';
import '../theme/app_colors.dart'; // Нужен для Icon
import '../theme/app_text_styles.dart'; // Чтобы использовать стили текста

class ServiceListItem extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceListItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Получаем тему для доступа к цветам и стилям текста
    final theme = Theme.of(context);

    return Card(
      // Используем наши отступы
      margin: const EdgeInsets.only(bottom: AppDimens.padding_12),
      elevation: 2.0, // Может быть в дизайне, пока оставляем по умолчанию
      shape: RoundedRectangleBorder(
        // Используем наши радиусы
        borderRadius: BorderRadius.circular(AppDimens.radius_8),
      ),
      child: ListTile(
        // Временно используем Icon.apps. Иконку, цвет и размер заменим, когда будет дизайн.
        leading: Icon(
          Icons.apps,
          color: theme.colorScheme.primary, // Используем основной цвет из темы
          size: AppDimens.iconSizeLarge,
        ),
        // Используем стили текста из темы
        title: Text(
          service.title,
          style: theme.textTheme.titleMedium, // Или другой подходящий стиль
        ),
        // Используем стили текста из темы для подзаголовка
        subtitle: Text(
          service.category ?? 'Без категории',
          style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary), // Второстепенный текст
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: AppDimens.iconSizeMedium,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}