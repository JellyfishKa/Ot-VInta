import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/screens/create_request_screen.dart';
import 'package:otvinta/services/api_service.dart';
import 'package:otvinta/theme/app_colors.dart';
import 'package:otvinta/theme/app_dimens.dart';
import 'package:otvinta/screens/services_screen.dart';
import 'package:otvinta/screens/requests_screen.dart';
import 'package:otvinta/screens/benefits_screen.dart';
import 'package:otvinta/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  int _selectedIndex = 0;
  List<RequestModel> _requests = [];
  bool _isLoading = true;

  static const List<String> _appBarTitles = <String>[
    '', // Пустой для экрана сервисов с логотипом
    'Мои заявки',
    'Льготы и программы',
    'Мой профиль'
  ];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  AppBar _buildAppBar() {
    if (_selectedIndex == 0) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/icons/logo.svg',
          height: AppDimens.iconSizeLarge,
        ),
        centerTitle: true,
      );
    }
    return AppBar(
      title: Text(_appBarTitles[_selectedIndex]),
      centerTitle: true,
    );
  }

  Future<void> _loadRequests() async {
    if (_requests.isEmpty) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final loadedRequests = await _apiService.fetchRequests();
      if (mounted) {
        setState(() {
          _requests = loadedRequests;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка загрузки заявок: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _performDeleteRequest(int id) async {
    final String idString = id.toString();
    final requestToRemove = _requests.firstWhere((req) => req.id == id);
    final index = _requests.indexOf(requestToRemove);
    setState(() {
      _requests.removeAt(index);
    });

    try {
      await _apiService.deleteRequest(idString);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Заявка "${requestToRemove.title}" удалена.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _requests.insert(index, requestToRemove);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка удаления: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _confirmAndDeleteRequest(int id) async {
    final bool? isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение'),
          content: const Text('Вы уверены, что хотите удалить заявку?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );

    if (isConfirmed == true) {
      await _performDeleteRequest(id);
    }
  }

  void _onServiceTap(ServiceModel service) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CreateRequestScreen(service: service),
      ),
    );

    if (mounted && result == true) {
      await _loadRequests();
      _onItemTapped(1);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ServicesScreen(onServiceTap: _onServiceTap),
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RequestsScreen(
              requests: _requests,
              onDeleteRequest: _confirmAndDeleteRequest,
            ),
      const BenefitsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/list.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/list.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: 'Сервисы',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: 'Мои заявки',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/balance.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/balance.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: 'Льготы',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/case.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/case.svg',
              height: AppDimens.iconSizeMedium,
              colorFilter:
                  const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        showUnselectedLabels: true,
      ),
    );
  }
}