import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/user_model.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

// Теперь это простой StatelessWidget
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем наши фейковые данные
    final user = UserModel.mock();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/icons/logo.svg', height: AppDimens.iconSizeLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppDimens.padding_24),
            CircleAvatar(
              radius: 50,
              backgroundImage: (user.avatarUrl != null) ? NetworkImage(user.avatarUrl!) : null,
              child: (user.avatarUrl == null) ? const Icon(Icons.person, size: 50) : null,
            ),
            const SizedBox(height: AppDimens.padding_16),
            Text(user.fullName, style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: AppDimens.padding_4),
            Text(user.position, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
            const SizedBox(height: AppDimens.padding_24),
            
            Card(
              elevation: 2,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radius_12)),
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.padding_16),
                child: Column(
                  children: [
                    _buildInfoRow(
                      iconSvg: 'tabel.svg',
                      title: 'Табельный номер',
                      value: user.employeeId ?? 'Не указан',
                    ),
                    const Divider(height: AppDimens.padding_24),
                    _buildInfoRow(
                      iconSvg: 'case.svg',
                      title: 'Департамент',
                      value: user.department ?? 'Не указан',
                    ),
                     const Divider(height: AppDimens.padding_24),
                    _buildInfoRow(
                      iconSvg: 'email.svg',
                      title: 'Корпоративная почта',
                      value: user.email,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.padding_32),
            
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Функция выхода в данный момент неактивна.')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Выйти из аккаунта'),
            ),
            const SizedBox(height: AppDimens.padding_24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String iconSvg, required String title, required String value}) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/$iconSvg',
          height: AppDimens.iconSizeMedium,
          colorFilter: const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
        ),
        const SizedBox(width: AppDimens.padding_16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.caption),
              const SizedBox(height: AppDimens.padding_4),
              Text(value, style: AppTextStyles.body),
            ],
          ),
        ),
      ],
    );
  }
}