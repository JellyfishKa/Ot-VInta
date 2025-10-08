import 'package:flutter/material.dart';
import 'package:head_ladder/models/request_model.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';

class StatusStepper extends StatelessWidget {
  final RequestStatus currentStatus;

  const StatusStepper({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final List<RequestStatus> statusOrder;
    if (currentStatus == RequestStatus.rejected) {
      statusOrder = [RequestStatus.pending, RequestStatus.rejected];
    } else {
      statusOrder = [RequestStatus.pending, RequestStatus.inProgress, RequestStatus.approved];
    }

    final int currentStatusIndex = statusOrder.indexOf(currentStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(statusOrder.length, (index) {
        final status = statusOrder[index];
        final bool isCompleted = index < currentStatusIndex;
        final bool isActive = index == currentStatusIndex;

        return _StatusStep(
          status: status,
          isLast: index == statusOrder.length - 1,
          isActive: isActive,
          isCompleted: isCompleted,
        );
      }),
    );
  }
}

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
    final color = _getColor();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: AppDimens.padding_20,
                height: AppDimens.padding_20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isActive || isCompleted) ? color : AppColors.white,
                  border: Border.all(color: color),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? color : AppColors.background,
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppDimens.padding_16),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : AppDimens.padding_20),
                child: _StatusChip(status: status, isActive: isActive),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getColor() {
    if (status == RequestStatus.rejected) return AppColors.statusRejectedBg;
    if (status == RequestStatus.approved) return AppColors.statusApprovedBg;
    if (isCompleted || isActive) return AppColors.primary;
    return AppColors.textSecondary;
  }
}

class _StatusChip extends StatelessWidget {
  final RequestStatus status;
  final bool isActive;

  const _StatusChip({required this.status, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.padding_16,
        vertical: AppDimens.padding_8,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        // ИСПРАВЛЕНО: Используем существующий радиус
        borderRadius: BorderRadius.circular(AppDimens.radius_20), 
        border: Border.all(
          // ИСПРАВЛЕНО: Упрощенная логика без isFinal()
          color: (isActive) ? Colors.transparent : AppColors.textSecondary,
        ),
      ),
      child: Text(
        status.displayName,
        style: AppTextStyles.body.copyWith(
          color: _getTextColor(),
          fontWeight: (isActive) ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!isActive) return AppColors.white;
    switch (status) {
      case RequestStatus.approved: return AppColors.statusApprovedBg;
      case RequestStatus.rejected: return AppColors.statusRejectedBg;
      case RequestStatus.inProgress: return AppColors.statusInProgressBg;
      case RequestStatus.pending: return AppColors.statusPendingBg;
    }
  }

  Color _getTextColor() {
     if (!isActive) return AppColors.textSecondary;
     switch (status) {
      // ИСПРАВЛЕНО: Используем правильные цвета текста из вашей темы
      case RequestStatus.approved: return AppColors.white; 
      case RequestStatus.rejected: return AppColors.white;
      case RequestStatus.inProgress: return AppColors.statusInProgressText;
      case RequestStatus.pending: return AppColors.statusPendingText;
    }
  }
}