import 'package:flutter/material.dart';
import 'dart:convert'; // Импорт для работы с JSON
import 'package:shared_preferences/shared_preferences.dart'; // Импорт нового пакета

// Импорты моделей и экранов
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/screens/create_request_screen.dart';
import 'services_screen.dart';
import 'requests_screen.dart';
import 'benefits_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<RequestModel> _requests = []; // Инициализируем пустым списком
  bool _isLoading = true; // Флаг для отображения индикатора загрузки

  @override
  void initState() {
    super.initState();
    // Загружаем сохраненные заявки при первом запуске экрана
    _loadRequests();
  }

  // Функция: Загрузка заявок из памяти
  Future<void> _loadRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final String? requestsString = prefs.getString('requests_data');

    if (requestsString != null) {
      final List<dynamic> requestsJson = jsonDecode(requestsString);
      setState(() {
        _requests = requestsJson.map((json) => RequestModel.fromJson(json)).toList();
      });
    }
    // После загрузки убираем индикатор
    setState(() {
      _isLoading = false;
    });
  }

  // Функция: Сохранение заявок в память
  Future<void> _saveRequests() async {
    final prefs = await SharedPreferences.getInstance();
    // Превращаем список объектов в список Map, а затем в строку JSON
    final String requestsString = jsonEncode(_requests.map((r) => r.toJson()).toList());
    await prefs.setString('requests_data', requestsString);
  }


  // Функция добавления новой заявки
  void _addRequest(ServiceModel service) {
    setState(() {
      _requests.insert(0,
        RequestModel(
        title: service.title,
        date: '06.10.2025', // Используем статичную дату для примера
        status: RequestStatus.pending,
      ));
    });
    _saveRequests(); // Сохраняем список после каждого добавления
  }

  // Функция навигации на экран создания
  void _onServiceTap(ServiceModel service) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CreateRequestScreen(service: service),
      ),
    );
    if (result == true) {
      _addRequest(service);
      _onItemTapped(1);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   static const List<String> _appBarTitles = <String>[
    'Доступные сервисы',
    'Мои заявки',
    'Льготы и программы',
    'Мой профиль'
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ServicesScreen(onServiceTap: _onServiceTap),
      _isLoading ? const Center(child: CircularProgressIndicator()) : RequestsScreen(requests: _requests),
      const BenefitsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Сервисы'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Мои заявки'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Льготы'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}