import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:head_ladder/models/service_model.dart';
import 'package:head_ladder/services/api_service.dart';
import '../theme/app_dimens.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

// Перечисление для управления состояниями экрана
enum ScreenState { confirmation, loading, success }

class CreateRequestScreen extends StatefulWidget {
  final ServiceModel service;

  const CreateRequestScreen({super.key, required this.service});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final ApiService _apiService = ApiService();
  ScreenState _currentState = ScreenState.confirmation;

  // Функция для отправки запроса
  Future<void> _submitRequest() async {
    setState(() {
      _currentState = ScreenState.loading;
    });

    try {
      // Вызываем API прямо с этого экрана
      await _apiService.createRequest(widget.service.id.toString());
      // В случае успеха - меняем состояние на "успех"
      setState(() {
        _currentState = ScreenState.success;
      });
    } catch (e) {
      // В случае ошибки - возвращаемся на подтверждение и показываем ошибку
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка создания заявки: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() {
          _currentState = ScreenState.confirmation;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Убираем автоматическую кнопку "назад"
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/icons/logo.svg', // Используем SVG логотип
          height: AppDimens.iconSizeLarge,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.padding_16),
          child: Card(
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radius_20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.padding_24),
              // AnimatedSwitcher плавно переключает виджеты при смене состояния
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildChildByState(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Роутер, который возвращает нужный виджет в зависимости от состояния
  Widget _buildChildByState() {
    switch (_currentState) {
      case ScreenState.loading:
        return const Center(
          key: ValueKey('loading'),
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      case ScreenState.success:
        return _buildSuccessChild();
      case ScreenState.confirmation:
        return _buildConfirmationChild();
    }
  }

  // Виджет для состояния ПОДТВЕРЖДЕНИЯ
  Widget _buildConfirmationChild() {
    return Column(
      key: const ValueKey('confirmation'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Подтвердите выбранную услугу', style: AppTextStyles.h2, textAlign: TextAlign.center),
        const SizedBox(height: AppDimens.padding_8),
        Text(widget.service.title, style: AppTextStyles.caption.copyWith(fontSize: 16)),
        const SizedBox(height: AppDimens.padding_24),
        
        // Кнопка "Подтверждение"
        ElevatedButton(
          onPressed: _submitRequest,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Растягиваем на всю ширину
          ),
          child: const Text('Подтверждение заявки'),
        ),
        const SizedBox(height: AppDimens.padding_12),

        // Кнопка "Отмена"
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false), // Возвращаем false
          style: OutlinedButton.styleFrom(
             minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Отмена'),
        ),
      ],
    );
  }

  // Виджет для состояния УСПЕХА
  Widget _buildSuccessChild() {
    return Column(
      key: const ValueKey('success'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Выбор успешно подтвержден!', style: AppTextStyles.h2, textAlign: TextAlign.center),
        const SizedBox(height: AppDimens.padding_12),
        Text(
          'Вы можете отслеживать статус своей заявки в разделе "Мои заявки"',
          style: AppTextStyles.caption.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.padding_24),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true), // Возвращаем true
          style: ElevatedButton.styleFrom(
             minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Вернуться назад'),
        ),
      ],
    );
  }
}