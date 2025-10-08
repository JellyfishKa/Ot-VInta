import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/services/api_service.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';
import 'package:otvinta/widgets/service_category_item.dart';

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

  // --- МАППИНГ ДАННЫХ ---
  // Превращаем ID категории в название
  String _getCategoryNameById(String categoryId) {
    switch (categoryId) {
      case '1': // Предполагаем, что 1 - это IT
        return 'IT-поддержка';
      case '2': // Предполагаем, что 2 - это HR
        return 'HR-отдел';
      case '3': // Добавим на будущее
        return 'Административный отдел';
      default:
        return 'Прочее';
    }
  }

  // Превращаем ID категории в имя SVG-файла иконки
  String _getIconSvgForCategoryById(String categoryId) {
    switch (categoryId) {
      case '1':
        return 'computer.svg';
      case '2':
        return 'tabel.svg'; // Используем иконку из ваших ассетов
      case '3':
        return 'calendar.svg';
      default:
        return 'list.svg';
    }
  }
  // -------------------------

  @override
  Widget build(BuildContext context) {
    // Убираем лишний Scaffold. HomeScreen предоставляет свой.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimens.padding_16),
          Text('Доступные сервисы', style: AppTextStyles.h1),
          const SizedBox(height: AppDimens.padding_8),
          Text(
            'Выберите категорию для просмотра подробной информации',
            style: AppTextStyles.caption.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppDimens.padding_24),

          Expanded(
            child: FutureBuilder<List<ServiceModel>>(
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
                // Группируем по-прежнему по ID, так как он уникален
                final groupedServices = groupBy(
                  services,
                  (ServiceModel service) => service.category ?? 'unknown',
                );
                final categoryIds = groupedServices.keys.toList();

                return ListView.separated(
                  itemCount: categoryIds.length,
                  itemBuilder: (context, index) {
                    final categoryId = categoryIds[index];
                    final servicesInCategory = groupedServices[categoryId]!;
                    
                    return ServiceCategoryItem(
                      // Используем наши новые функции для получения правильных данных
                      categoryTitle: _getCategoryNameById(categoryId),
                      categoryIconSvg: _getIconSvgForCategoryById(categoryId),
                      services: servicesInCategory,
                      onServiceTap: widget.onServiceTap,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: AppDimens.padding_12),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}