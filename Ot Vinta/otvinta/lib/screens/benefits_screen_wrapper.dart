import 'package:flutter/material.dart';
import 'package:otvinta/screens/benefits_screen.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

class BenefitsScreenWrapper extends StatelessWidget {
  const BenefitsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // --- ИЗМЕНЕНО: AppBar полностью стилизован ---
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Увеличили высоту для отступов
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Льготы и программы', style: AppTextStyles.h1),
                 const SizedBox(height: AppDimens.padding_8),
                 Text(
                  'Выберите программу для просмотра подробной информации',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppDimens.padding_16),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: const BenefitsScreen(),
    );
  }
}