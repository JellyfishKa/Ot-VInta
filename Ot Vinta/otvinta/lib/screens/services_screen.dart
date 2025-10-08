import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../services/api_service.dart';
import '../widgets/service_list_item.dart'; 
import '../theme/app_dimens.dart';

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

  @override
  Widget build(BuildContext context) {
    // Получаем тему для доступа к цветам (например, для ошибки)
    final theme = Theme.of(context);

    return FutureBuilder<List<ServiceModel>>(
      future: _servicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.padding_16),
              child: Text(
                'Ошибка загрузки услуг: ${snapshot.error}',
                textAlign: TextAlign.center,
                // Используем стиль из темы и цвет ошибки
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Доступные услуги отсутствуют.'));
        }

        final services = snapshot.data!;

        // Используем ListView.separated для автоматического добавления отступов между элементами
        return ListView.separated(
          // Используем стандартные отступы из нашей дизайн-системы
          padding: const EdgeInsets.all(AppDimens.padding_16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            // --- ГЛАВНОЕ ИЗМЕНЕНИЕ: Используем наш кастомный виджет ---
            return ServiceListItem(
              service: service,
              onTap: () => widget.onServiceTap(service),
            );
          },
          // Виджет-разделитель (здесь просто пустой отступ)
          separatorBuilder: (context, index) => const SizedBox(height: AppDimens.padding_8),
        );
      },
    );
  }
}