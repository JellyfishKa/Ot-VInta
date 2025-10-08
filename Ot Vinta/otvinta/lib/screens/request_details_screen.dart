import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:head_ladder/models/request_model.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';
import 'package:head_ladder/widgets/status_stepper.dart';

class RequestDetailsScreen extends StatelessWidget {
  final RequestModel request;
  // --- ДОБАВЛЕНО: Принимаем название сервиса ---
  final String serviceName;

  const RequestDetailsScreen({
    super.key,
    required this.request,
    required this.serviceName,
  });

  // --- НОВЫЙ МЕТОД: Форматирование даты ---
  String _formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('dd.MM.yyyy').format(dateTime);
    } catch (e) {
      // Если формат даты некорректный, возвращаем исходную строку
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        // --- ИЗМЕНЕНИЯ В APPBAR ---
        backgroundColor: AppColors.background, // Явно указываем цвет фона
        elevation: 0,
        leading: IconButton( // Кастомная кнопка назад для точного вида
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO: Замените на ваше лого из ассетов
            const Icon(Icons.api, color: AppColors.primary, size: AppDimens.iconSizeLarge),
            const SizedBox(width: AppDimens.padding_8),
            Text('Head Ladder', style: AppTextStyles.logo),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.padding_16),
        child: Container(
          // --- ИЗМЕНЕНИЯ В КАРТОЧКЕ ---
          padding: const EdgeInsets.all(AppDimens.padding_24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimens.radius_20), // Радиус как в макете
             boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Детали заявки:', style: AppTextStyles.h2),
              const SizedBox(height: AppDimens.padding_24),
              Row(
                children: [
                  _buildInfoColumn('ID заявки:', "M-${request.id}"),
                  const SizedBox(width: AppDimens.padding_32),
                  // --- ИЗМЕНЕНО: Используем форматирование даты ---
                  _buildInfoColumn('Дата:', _formatDate(request.date)),
                ],
              ),
              const SizedBox(height: AppDimens.padding_24),
              // --- ИЗМЕНЕНО: В описании показываем и title, и название сервиса ---
              _buildInfoColumn('Описание:', '${request.title}\n[$serviceName]'),
              const SizedBox(height: AppDimens.padding_32),
              Text('Путь заявки:', style: AppTextStyles.h2),
              const SizedBox(height: AppDimens.padding_16),
              StatusStepper(currentStatus: request.status),
            ],
          ),
        ),
      ),
    );
  }

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