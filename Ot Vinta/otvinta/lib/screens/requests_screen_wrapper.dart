import 'package:flutter/material.dart';
import 'package:head_ladder/logic/requests_logic.dart';
import 'package:head_ladder/screens/requests_screen.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/theme/app_text_styles.dart';
import 'package:head_ladder/widgets/headladder_app_bar.dart';

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
      // --- ИЗМЕНЕНО: Вся логика AppBar теперь в одном месте ---
      appBar: HeadLadderAppBar(
        // title не указываем, чтобы отображался логотип
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          // --- УЛУЧШЕНО: Добавили выравнивание и отступы для консистентности ---
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Активные заявки', style: AppTextStyles.h1),
            ),
          ),
        ),
      ),
      body: _logic.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RequestsScreen(
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