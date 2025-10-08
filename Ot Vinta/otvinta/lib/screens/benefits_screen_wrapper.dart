import 'package:flutter/material.dart';
import 'package:head_ladder/screens/benefits_screen.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';
import 'package:head_ladder/widgets/headladder_app_bar.dart';

class BenefitsScreenWrapper extends StatelessWidget {
  const BenefitsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // --- ИСПОЛЬЗУЕМ НАШ ФИНАЛЬНЫЙ APPBAR ---
      appBar: HeadLadderAppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Льготы и программы', style: AppTextStyles.h1),
                 const SizedBox(height: AppDimens.padding_8),
                 Text(
                  'Выберите программу для просмотра подробной информации',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const BenefitsScreen(),
    );
  }
}