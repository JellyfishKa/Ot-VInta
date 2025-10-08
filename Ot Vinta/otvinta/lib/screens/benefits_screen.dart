import 'package:flutter/material.dart';
import 'package:otvinta/models/benefit_model.dart';
import 'package:otvinta/services/api_service.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/theme/app_text_styles.dart';
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

  // Вспомогательная функция для выбора иконки по названию льготы
  String _getIconForBenefit(BenefitModel benefit) {
    final title = benefit.title.toLowerCase();

    // Ищем английские ключевые слова
    if (title.contains('insurance') || title.contains('health')) {
      return 'medicine.svg';
    }
    if (title.contains('learning') || title.contains('library')) {
      return 'tabel.svg'; // Иконка документа/табеля для обучения
    }
    if (title.contains('discount') || title.contains('compensation')) {
      return 'balance.svg'; // Иконка баланса для скидок и компенсаций
    }
    if (title.contains('bonus') || title.contains('referral')) {
      return 'case.svg'; // Иконка портфеля/кейса для бонусов
    }
    
    // Иконка по умолчанию, если ничего не подошло
    return 'bookmark.svg';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppDimens.padding_16),
          Text('Льготы и программы', style: AppTextStyles.h1),
          const SizedBox(height: AppDimens.padding_8),
          Text(
            'Выберите категорию для просмотра подробной информации',
            style: AppTextStyles.caption.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppDimens.padding_24),

          Expanded(
            child: FutureBuilder<List<BenefitModel>>(
              future: _benefitsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка загрузки: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Список льгот пуст.'));
                }

                final benefits = snapshot.data!;

                return ListView.separated(
                  itemCount: benefits.length,
                  itemBuilder: (context, index) {
                    final benefit = benefits[index];
                    return BenefitCategoryItem(
                      benefit: benefit,
                      iconSvg: _getIconForBenefit(benefit),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimens.padding_12),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}