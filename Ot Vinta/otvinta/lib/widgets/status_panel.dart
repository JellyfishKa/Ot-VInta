import 'package:flutter/material.dart';
import 'package:head_ladder/models/request_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

class StatusPanel extends StatelessWidget {
  final RequestStatus status;

  const StatusPanel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Выбираем цвета и текст в зависимости от статуса
    final Color backgroundColor;
    final Color textColor;

    switch (status) {
      case RequestStatus.approved:
        backgroundColor = AppColors.statusApprovedBg;
        textColor = AppColors.white;
        break;
      case RequestStatus.inProgress:
        backgroundColor = AppColors.statusInProgressBg;
        textColor = AppColors.statusInProgressText;
        break;
      case RequestStatus.rejected:
        backgroundColor = AppColors.statusRejectedBg;
        textColor = AppColors.white;
        break;
      case RequestStatus.pending:
        backgroundColor = AppColors.statusPendingBg;
        textColor = AppColors.statusPendingText;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.padding_4,
        horizontal: AppDimens.padding_12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimens.radius_12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600, // SemiBold
          fontSize: 14,
        ),
      ),
    );
  }
}