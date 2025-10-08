// lib/screens/request_details_screen.dart

import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';
import 'package:otvinta/widgets/status_stepper.dart';

class RequestDetailsScreen extends StatelessWidget {
  final RequestModel request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Используем цвет фона из дизайн-системы
      backgroundColor: AppColors.background,
      appBar: AppBar(
        // Прозрачный AppBar, чтобы был виден цвет фона Scaffold
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Стандартная кнопка "назад" будет стилизована глобальной темой
        // Убираем автоматическую тень от иконки
        iconTheme: Theme.of(context).iconTheme.copyWith(color: AppColors.textPrimary),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Здесь можно вставить ваше лого из ассетов, например:
            // Image.asset('assets/logo.png', height: 24),
            // Пока используем иконку-плейсхолдер
            const Icon(Icons.shield_outlined, color: AppColors.primary, size: AppDimens.iconSizeLarge),
            const SizedBox(width: AppDimens.padding_8),
            Text('Head Ladder', style: AppTextStyles.logo),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Используем отступы из дизайн-системы
        padding: const EdgeInsets.all(AppDimens.padding_16),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radius_12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.padding_24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ЗАГОЛОВОК "Детали заявки"
                Text('Детали заявки:', style: AppTextStyles.h2),
                const SizedBox(height: AppDimens.padding_24),

                // СТРОКА С ID И ДАТОЙ
                Row(
                  children: [
                    _buildInfoColumn('ID заявки:', "M-${request.id}"),
                    const SizedBox(width: AppDimens.padding_32),
                    _buildInfoColumn('Дата:', request.date), // TODO: отформатируйте дату, если нужно
                  ],
                ),
                const SizedBox(height: AppDimens.padding_24),

                // СЕКЦИЯ "Описание"
                _buildInfoColumn('Описание:', request.title),
                const SizedBox(height: AppDimens.padding_32),

                // ЗАГОЛОВОК "Путь заявки"
                Text('Путь заявки:', style: AppTextStyles.h2),
                const SizedBox(height: AppDimens.padding_16),

                // ИНТЕГРАЦИЯ ВИДЖЕТА СТАТУСОВ
                StatusStepper(currentStatus: request.status),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Вспомогательный виджет для отрисовки колонки "Заголовок-Значение".
  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.caption),
        const SizedBox(height: AppDimens.padding_4),
        Text(value, style: AppTextStyles.h3),
      ],
    );
  }
}