import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:head_ladder/models/service_model.dart';
import 'package:head_ladder/services/api_service.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/widgets/service_category_item.dart';

class ServicesScreen extends StatefulWidget {
  final Function(ServiceModel) onServiceTap;

  const ServicesScreen({super.key, required this.onServiceTap});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Future<List<ServiceModel>> _servicesFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _servicesFuture = _apiService.fetchServices();
  }

  String _getCategoryNameById(String categoryId) {
    switch (categoryId) {
      case '1':
        return 'IT-поддержка';
      case '2':
        return 'HR-отдел';
      case '3':
        return 'Административный отдел';
      default:
        return 'Прочее';
    }
  }

  String _getIconSvgForCategoryById(String categoryId) {
    switch (categoryId) {
      case '1':
        return 'computer.svg';
      case '2':
        return 'tabel.svg';
      case '3':
        return 'calendar.svg';
      default:
        return 'list.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- ИЗМЕНЕНО: Убрана лишняя разметка (Column, Text), так как заголовок теперь в AppBar ---
    return FutureBuilder<List<ServiceModel>>(
      future: _servicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Услуги не найдены.'));
        }

        final services = snapshot.data!;
        final groupedServices = groupBy(
          services,
          (ServiceModel service) => service.category ?? 'unknown',
        );
        final categoryIds = groupedServices.keys.toList();

        return ListView.separated(
          // --- ИЗМЕНЕНО: Отступы теперь применяются здесь ---
          padding: const EdgeInsets.all(AppDimens.padding_16),
          itemCount: categoryIds.length,
          itemBuilder: (context, index) {
            final categoryId = categoryIds[index];
            final servicesInCategory = groupedServices[categoryId]!;
            
            return ServiceCategoryItem(
              categoryTitle: _getCategoryNameById(categoryId),
              categoryIconSvg: _getIconSvgForCategoryById(categoryId),
              services: servicesInCategory,
              onServiceTap: widget.onServiceTap,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: AppDimens.padding_12),
        );
      },
    );
  }
}