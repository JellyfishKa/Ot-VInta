import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

class ServiceCategoryItem extends StatefulWidget {
  final String categoryTitle;
  final String categoryIconSvg;
  final List<ServiceModel> services;
  final Function(ServiceModel) onServiceTap;

  const ServiceCategoryItem({
    super.key,
    required this.categoryTitle,
    required this.categoryIconSvg,
    required this.services,
    required this.onServiceTap,
  });

  @override
  State<ServiceCategoryItem> createState() => _ServiceCategoryItemState();
}

class _ServiceCategoryItemState extends State<ServiceCategoryItem> {
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
        borderRadius: BorderRadius.circular(AppDimens.radius_12),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding_20,
              vertical: AppDimens.padding_8,
            ),
            leading: SvgPicture.asset(
              'assets/icons/${widget.categoryIconSvg}',
              height: AppDimens.iconSizeLarge,
              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            title: Text(widget.categoryTitle, style: AppTextStyles.h3),
            onTap: _toggleExpansion,
            trailing: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.expand_more, color: AppColors.textSecondary),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: _buildServicesList(),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          )
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return Column(
      children: [
        const Divider(
          color: AppColors.divider,
          indent: AppDimens.padding_20,
          endIndent: AppDimens.padding_20,
          height: 1,
        ),
        ...widget.services.map((service) => ListTile(
              contentPadding: const EdgeInsets.only(
                left: AppDimens.padding_32,
                right: AppDimens.padding_20,
              ),
              title: Text(service.title, style: AppTextStyles.body),
              onTap: () => widget.onServiceTap(service),
            )),
        const SizedBox(height: AppDimens.padding_8),
      ],
    );
  }
}