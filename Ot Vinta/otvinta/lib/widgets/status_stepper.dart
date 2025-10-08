// lib/widgets/status_stepper.dart

import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

/// Виджет для отображения вертикального пути заявки.
///
/// Он отображает полный возможный путь и подсвечивает текущий статус,
/// основываясь на цветах и стилях из дизайн-системы.
class StatusStepper extends StatelessWidget {
  final RequestStatus currentStatus;
  
  // Стандартный и неизменный путь заявки, как показано на макете.
  final List<RequestStatus> statusOrder;

  const StatusStepper({
    super.key,
    required this.currentStatus,
    this.statusOrder = const [
      RequestStatus.pending,
      RequestStatus.inProgress,
      RequestStatus.approved,
    ],
  });

  @override
  Widget build(BuildContext context) {
    final int currentStatusIndex = statusOrder.indexOf(currentStatus);

    // Используем Column, так как количество статусов невелико и фиксировано.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < statusOrder.length; i++)
          _StatusStep(
            status: statusOrder[i],
            isLast: i == statusOrder.length - 1,
            isActive: statusOrder[i] == currentStatus,
            isCompleted: i < currentStatusIndex,
          ),
      ],
    );
  }
}

/// Приватный виджет для отрисовки одного шага: чип статуса и линия под ним.
class _StatusStep extends StatelessWidget {
  final RequestStatus status;
  final bool isLast;
  final bool isActive;
  final bool isCompleted;

  const _StatusStep({
    required this.status,
    required this.isLast,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    // Определяем цвета на основе состояния
    final Color activeColor = AppColors.statusInProgressText;
    final Color inactiveColor = AppColors.divider;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ЧИП С НАЗВАНИЕМ СТАТУСА
        _StatusChip(
          status: status,
          isActive: isActive,
        ),

        // СОЕДИНИТЕЛЬНАЯ ЛИНИЯ
        if (!isLast)
          Container(
            height: AppDimens.padding_24, // Высота линии-разделителя
            width: 2,
            // Горизонтальный отступ, чтобы линия была примерно по центру чипа
            margin: const EdgeInsets.only(left: 48, top: AppDimens.padding_4, bottom: AppDimens.padding_4),
            color: isCompleted ? activeColor : inactiveColor,
          ),
      ],
    );
  }
}

/// Виджет для "чипа" статуса, стилизованный в соответствии с макетом.
class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.status,
    required this.isActive,
  });

  final RequestStatus status;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.padding_20,
        vertical: AppDimens.padding_8,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.statusInProgressBg : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radius_20),
        border: Border.all(
          color: isActive ? Colors.transparent : AppColors.divider,
        ),
      ),
      child: Text(
        status.displayName,
        style: isActive
            ? AppTextStyles.body.copyWith(
                color: AppColors.statusInProgressText,
                fontWeight: FontWeight.bold,
              )
            : AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
      ),
    );
  }
}