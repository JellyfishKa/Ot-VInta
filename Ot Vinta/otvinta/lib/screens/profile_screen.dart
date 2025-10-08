import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:head_ladder/models/user_model.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';
import 'package:head_ladder/widgets/headladder_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем наши фейковые данные
    final user = UserModel.mock();

    return Scaffold(
      backgroundColor: AppColors.background,
      // --- ИЗМЕНЕНО: Используем наш стандартный AppBar ---
      appBar: const HeadLadderAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppDimens.padding_16),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.divider,
                      backgroundImage: (user.avatarUrl != null) ? NetworkImage(user.avatarUrl!) : null,
                      child: const Icon(Icons.person, size: 50, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: AppDimens.padding_16),
                    Text(user.fullName, style: AppTextStyles.h2, textAlign: TextAlign.center),
                    const SizedBox(height: AppDimens.padding_4),
                    Text(user.position, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                    const SizedBox(height: AppDimens.padding_32),
                    
                    // --- ИЗМЕНЕНО: Карточка с информацией ---
                    Container(
                      padding: const EdgeInsets.all(AppDimens.padding_20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppDimens.radius_20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            iconSvg: 'tabel.svg',
                            title: 'Табельный номер',
                            value: user.employeeId ?? 'Не указан',
                          ),
                          const SizedBox(height: AppDimens.padding_24),
                          _buildInfoRow(
                            iconSvg: 'case.svg',
                            title: 'Департамент',
                            value: user.department ?? 'Не указан',
                          ),
                          const SizedBox(height: AppDimens.padding_24),
                          _buildInfoRow(
                            iconSvg: 'email.svg',
                            title: 'Корпоративная почта',
                            value: user.email,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // --- ИЗМЕНЕНО: Кнопка "Выйти" ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.padding_24),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Реализовать логику выхода из аккаунта
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Функция выхода будет реализована.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0), // Растягиваем на всю ширину
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.padding_20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radius_12),
                  ),
                ),
                child: const Text('Выйти из аккаунта'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String iconSvg, required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/icons/$iconSvg',
          height: AppDimens.iconSizeLarge,
          colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
        ),
        const SizedBox(width: AppDimens.padding_16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: AppDimens.padding_4),
              Text(value, style: AppTextStyles.h3.copyWith(height: 1.2)),
            ],
          ),
        ),
      ],
    );
  }
}