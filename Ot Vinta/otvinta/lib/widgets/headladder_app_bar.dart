import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';

class HeadLadderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  // --- ДОБАВЛЕНО: Свойство для сложного заголовка ---
  final PreferredSizeWidget? bottom;

  const HeadLadderAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.actions,
    this.bottom, // --- ДОБАВЛЕНО в конструктор
  });

  @override
  Widget build(BuildContext context) {
    Widget titleWidget;
    if (title != null && title!.isNotEmpty) {
      titleWidget = Text(title!, style: AppTextStyles.h2);
    } else {
      // Если title не указан, используем логотип
      titleWidget = SvgPicture.asset(
        'assets/icons/logo.svg',
        height: AppDimens.iconSizeXLarge,
      );
    }

    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBackButton && Navigator.canPop(context)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: titleWidget,
      actions: actions,
      // --- ДОБАВЛЕНО: Передаем bottom в стандартный AppBar ---
      bottom: bottom,
    );
  }

  // --- ИЗМЕНЕНО: Размер теперь учитывает высоту bottom-виджета ---
  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}