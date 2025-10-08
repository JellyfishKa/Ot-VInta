import 'package:flutter/material.dart';
import 'package:head_ladder/models/service_model.dart';
import 'package:head_ladder/screens/create_request_screen.dart';
import 'package:head_ladder/screens/services_screen.dart';
import 'package:head_ladder/theme/app_colors.dart';
import 'package:head_ladder/widgets/headladder_app_bar.dart';


class ServicesScreenWrapper extends StatelessWidget {
  const ServicesScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
     void onServiceTap(ServiceModel service) async {
        final result = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (context) => CreateRequestScreen(service: service),
          ),
        );
        if(result == true && context.mounted) {
            Navigator.of(context).pop();
        }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      // --- ИЗМЕНЕНО: Стандартный AppBar заменен на наш кастомный ---
      appBar: const HeadLadderAppBar(
        title: 'Доступные сервисы',
      ),
      body: ServicesScreen(onServiceTap: onServiceTap),
    );
  }
}