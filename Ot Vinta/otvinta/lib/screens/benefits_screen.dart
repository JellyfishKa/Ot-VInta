import 'package:flutter/material.dart';
import 'package:head_ladder/models/benefit_model.dart'; // Убедитесь, что путь к модели верный
import 'package:head_ladder/services/api_service.dart';
import 'package:head_ladder/theme/app_dimens.dart';
import 'package:head_ladder/widgets/benefit_category_item.dart';

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

  // --- ИЗМЕНЕНО: Логика теперь работает с ID категорий, а не с их названиями ---
  String _getIconForBenefit(BenefitModel benefit) {
    final categoryId = benefit.category; // Получаем ID, например "4"

    switch (categoryId) {
      // TODO: Проверьте, что ID и иконки соответствуют. Если нет - просто поменяйте.
      // Например, если для ID "4" нужна иконка медицины, напишите: return 'medicine.svg';
// Предположительно "Профессиональное развитие"
      case '4': // Предположительно "Профессиональное развитие"
        return 'tabel.svg';

      case '5': // Предположительно "Финансы и бонусы"
        return 'balance.svg';

      // Добавим на будущее ID для медицины, если он появится
      case '6':
        return 'medicine.svg';

      default:
        // Иконка по умолчанию для всех остальных ID
        return 'bookmark.svg';
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
          return const Center(child: Text('Произошла ошибка загрузки данных.'));
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