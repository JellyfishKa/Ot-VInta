import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/widgets/status_panel.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';

class RequestListItem extends StatelessWidget {
  final RequestModel request;
  final VoidCallback onTap;

  const RequestListItem({
    super.key,
    required this.request,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radius_20),
      child: Ink(
        padding: const EdgeInsets.all(AppDimens.padding_16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.radius_20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID заявки:', style: AppTextStyles.caption),
                    const SizedBox(height: AppDimens.padding_4),
                    Text(request.id.toString(), style: AppTextStyles.h3),
                  ],
                ),
                StatusPanel(status: request.status),
              ],
            ),
            const SizedBox(height: AppDimens.padding_12),
            Text(
              '[${request.title}]',
              style: AppTextStyles.caption.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}