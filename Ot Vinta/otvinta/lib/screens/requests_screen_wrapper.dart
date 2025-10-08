import 'package:flutter/material.dart';
import 'package:otvinta/logic/requests_logic.dart';
import 'package:otvinta/screens/requests_screen.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';

class RequestsScreenWrapper extends StatefulWidget {
  const RequestsScreenWrapper({super.key});

  @override
  State<RequestsScreenWrapper> createState() => _RequestsScreenWrapperState();
}

class _RequestsScreenWrapperState extends State<RequestsScreenWrapper> {
  final RequestsLogic _logic = RequestsLogic();

  @override
  void initState() {
    super.initState();
    // --- ИЗМЕНЕНО: Вызываем новый метод для загрузки всех данных ---
    _logic.loadData(
      (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error),
            backgroundColor: AppColors.error,
          ));
        }
      },
      () {
        if (mounted) setState(() {});
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // --- ИЗМЕНЕНО: AppBar приведен в соответствие с дизайном ---
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
        // --- ДОБАВЛЕНО: Заголовок "Активные заявки" под AppBar ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Text(
            'Активные заявки',
            style: AppTextStyles.h2
          ),
        ),
        centerTitle: true,
      ),
      body: _logic.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RequestsScreen(
              // --- ИЗМЕНЕНО: Передаем оба набора данных ---
              requests: _logic.requests,
              servicesMap: _logic.servicesMap,
              onDeleteRequest: (id) {
                _logic.confirmAndDeleteRequest(
                  context: context,
                  id: id,
                  onSuccess: () {
                    if (mounted) setState(() {});
                  },
                  onError: (error) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error),
                        backgroundColor: AppColors.error,
                      ));
                    }
                  }
                );
              },
            ),
    );
  }
}