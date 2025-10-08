import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/benefit_model.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

class BenefitCategoryItem extends StatefulWidget {
  final BenefitModel benefit;
  final String iconSvg;

  const BenefitCategoryItem({
    super.key,
    required this.benefit,
    required this.iconSvg,
  });

  @override
  State<BenefitCategoryItem> createState() => _BenefitCategoryItemState();
}

class _BenefitCategoryItemState extends State<BenefitCategoryItem> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius_20),
      ),
      child: Column(
        children: [
          // Кликабельный заголовок
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding_20,
              vertical: AppDimens.padding_12,
            ),
            leading: SvgPicture.asset(
              'assets/icons/${widget.iconSvg}',
              height: AppDimens.iconSizeLarge,
              // Цвет иконки для льгот может отличаться, настраиваем по макету
              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            title: Text(widget.benefit.title, style: AppTextStyles.h3),
            onTap: _toggleExpansion,
            trailing: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.expand_more, color: AppColors.textSecondary),
            ),
          ),
          // Анимированное раскрытие описания
          AnimatedCrossFade(
            firstChild: Container(), // Пусто, когда свернуто
            secondChild: _buildDescription(),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          )
        ],
      ),
    );
  }

  // Виджет для текстового описания
  Widget _buildDescription() {
    // Проверяем, есть ли вообще описание
    if (widget.benefit.description == null || widget.benefit.description!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimens.padding_20,
        right: AppDimens.padding_20,
        bottom: AppDimens.padding_20,
      ),
      child: Column(
        children: [
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: AppDimens.padding_12),
          Text(
            widget.benefit.description!,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}