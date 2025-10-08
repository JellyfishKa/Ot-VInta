import 'package:flutter/material.dart';
import 'package:otvinta/models/benefit_model.dart'; // Убедитесь, что путь к модели верный
import 'package:otvinta/services/api_service.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/widgets/benefit_category_item.dart';

class BenefitsScreen extends StatefulWidget {
  const BenefitsScreen({super.key});

  @override
  State<BenefitsScreen> createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  late Future<List<BenefitModel>> _benefitsFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _benefitsFuture = _apiService.fetchBenefits();
  }

  // Здесь происходит выбор правильной иконки на основе категории
  String _getIconForBenefit(BenefitModel benefit) {
    final category = benefit.category;

    switch (category) {
      case 'Здоровье и спорт':
        return 'medicine.svg'; // Ваш файл
      case 'Профессиональное развитие':
        return 'tabel.svg'; // Ваш файл
      case 'Финансы и бонусы':
        return 'balance.svg'; // Ваш файл
      default:
        return 'bookmark.svg'; // Иконка по умолчанию
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BenefitModel>>(
      future: _benefitsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Произошла ошибка загрузки данных.'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Доступных льгот и программ нет.'));
        }

        final benefits = snapshot.data!.where((b) => b.isActive).toList();
        
        if (benefits.isEmpty) {
          return const Center(child: Text('В данный момент нет активных льгот.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: benefits.length,
          itemBuilder: (context, index) {
            final benefit = benefits[index];
            return BenefitCategoryItem(
              benefit: benefit,
              // Передаем правильное имя иконки в виджет
              iconSvgName: _getIconForBenefit(benefit),
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppDimens.padding_12),
        );
      },
    );
  }
}