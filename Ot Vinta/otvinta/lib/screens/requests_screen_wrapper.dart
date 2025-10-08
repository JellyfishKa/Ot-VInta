import 'package:flutter/material.dart';
import 'package:otvinta/logic/requests_logic.dart';
import 'package:otvinta/screens/requests_screen.dart';
import 'package:otvinta/theme/app_colors.dart';

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
    _logic.loadRequests(
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
      appBar: AppBar(title: const Text('Мои заявки'), centerTitle: true),
      body: _logic.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RequestsScreen(
              requests: _logic.requests,
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