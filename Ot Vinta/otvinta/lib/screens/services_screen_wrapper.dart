import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/screens/create_request_screen.dart';
import 'package:otvinta/screens/services_screen.dart';
import 'package:otvinta/theme/app_dimens.dart';

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
            Navigator.of(context).pop(); // Go back from wrapper to refresh previous screen
        }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/icons/logo.svg', height: AppDimens.iconSizeLarge),
        centerTitle: true,
      ),
      body: ServicesScreen(onServiceTap: onServiceTap),
    );
  }
}