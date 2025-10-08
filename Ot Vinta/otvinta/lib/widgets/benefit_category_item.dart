import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/benefit_model.dart'; 
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

class BenefitCategoryItem extends StatefulWidget {
  final BenefitModel benefit;
  final String iconSvgName; // Используем это имя параметра

  const BenefitCategoryItem({
    super.key,
    required this.benefit,
    required this.iconSvgName,
  });

  @override
  State<BenefitCategoryItem> createState() => _BenefitCategoryItemState();
}

class _BenefitCategoryItemState extends State<BenefitCategoryItem> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    if (widget.benefit.description != null && widget.benefit.description!.isNotEmpty) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasDescription = widget.benefit.description != null && widget.benefit.description!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
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
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding_20,
              vertical: AppDimens.padding_8,
            ),
            leading: SizedBox(
              width: AppDimens.iconSizeLarge,
              height: AppDimens.iconSizeLarge,
              child: SvgPicture.asset(
                'assets/icons/${widget.iconSvgName}', // <- Вот здесь используется иконка
                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
            ),
            title: Text(widget.benefit.title, style: AppTextStyles.h3),
            onTap: _toggleExpansion,
            trailing: hasDescription
                ? AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more, color: AppColors.textSecondary),
                  )
                : null,
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: _buildDescription(),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          )
        ],
      ),
    );
  }

  Widget _buildDescription() {
    if (widget.benefit.description == null || widget.benefit.description!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.padding_20, 0, AppDimens.padding_20, AppDimens.padding_20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: AppColors.divider, height: 1, thickness: 1),
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