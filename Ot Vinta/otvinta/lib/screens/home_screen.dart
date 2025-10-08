import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/user_model.dart';
import 'package:otvinta/screens/benefits_screen_wrapper.dart';
import 'package:otvinta/screens/profile_screen.dart';
import 'package:otvinta/screens/requests_screen_wrapper.dart';
import 'package:otvinta/screens/services_screen_wrapper.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

// Теперь это простой StatelessWidget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем наши фейковые данные
    final user = UserModel.mock();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/icons/logo.svg', height: AppDimens.iconSizeLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGreeting(user),
            const SizedBox(height: AppDimens.padding_32),
            _buildNavigationButton(
              'Личный кабинет',
              isPrimary: false,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
            ),
            const SizedBox(height: AppDimens.padding_16),
            _buildNavigationButton(
              'Мои заявки',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestsScreenWrapper()));
              },
            ),
            const SizedBox(height: AppDimens.padding_16),
            _buildNavigationButton(
              'Льготы и программы',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BenefitsScreenWrapper()));
              },
            ),
            const SizedBox(height: AppDimens.padding_16),
            _buildNavigationButton(
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Здравствуйте,', style: AppTextStyles.h1.copyWith(fontWeight: FontWeight.w500)),
              Text('${user.firstName}!', style: AppTextStyles.h1),
            ],
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) 
              ? NetworkImage(user.avatarUrl!) 
              : null,
          backgroundColor: AppColors.divider,
          child: (user.avatarUrl == null || user.avatarUrl!.isEmpty) 
              ? const Icon(Icons.person, color: AppColors.textSecondary) 
              : null,
        ),
      ],
    );
  }

  Widget _buildNavigationButton(String text, {required VoidCallback onPressed, bool isPrimary = true}) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.padding_16),
        ),
        child: Text(text),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
         style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.padding_16),
        ),
        child: Text(text),
      );
    }
  }
}