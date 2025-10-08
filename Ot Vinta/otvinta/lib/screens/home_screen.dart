import 'package:flutter/material.dart';
import 'package:head_ladder/models/user_model.dart';
import 'package:head_ladder/screens/benefits_screen_wrapper.dart';
import 'package:head_ladder/screens/profile_screen.dart';
import 'package:head_ladder/screens/requests_screen_wrapper.dart';
import 'package:head_ladder/screens/services_screen_wrapper.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';
import 'package:head_ladder/widgets/headladder_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем наши фейковые данные
    final user = UserModel.mock();

    return Scaffold(
      backgroundColor: AppColors.background,
      // --- ИЗМЕНЕНО: Используем наш стандартный AppBar без кнопки "назад" ---
      appBar: const HeadLadderAppBar(
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimens.padding_16),
            _buildGreeting(user),
            const SizedBox(height: AppDimens.padding_32),
            _buildNavigationButton(
              context,
              'Личный кабинет',
              isPrimary: false,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
            ),
            const SizedBox(height: AppDimens.padding_16),
            _buildNavigationButton(
              context,
              'Мои заявки',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestsScreenWrapper()));
              },
            ),
            const SizedBox(height: AppDimens.padding_16),
            _buildNavigationButton(
              context,
              'Льготы и программы',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BenefitsScreenWrapper()));
              },
            ),
            const SizedBox(height: AppDimens.padding_16),
            _buildNavigationButton(
              context,
              'Доступные сервисы',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ServicesScreenWrapper()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(UserModel user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Здравствуйте,', style: AppTextStyles.h1.copyWith(fontWeight: FontWeight.normal)),
              Text('${user.firstName}!', style: AppTextStyles.h1),
            ],
          ),
        ),
        const SizedBox(width: AppDimens.padding_16),
        CircleAvatar(
          radius: 36, // Немного увеличим радиус для соответствия макету
          backgroundColor: AppColors.divider,

          backgroundImage: (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
              ? NetworkImage(user.avatarUrl!)
              : null,
          child: const Icon(Icons.person, color: AppColors.textSecondary, size: 36),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(BuildContext context, String text, {required VoidCallback onPressed, bool isPrimary = true}) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.radius_12),
    );
    const padding = EdgeInsets.symmetric(vertical: AppDimens.padding_20);

    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: shape,
          padding: padding,
        ),
        child: Text(text),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
         style: OutlinedButton.styleFrom(
          shape: shape,
          padding: padding,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        child: Text(text),
      );
    }
  }
}