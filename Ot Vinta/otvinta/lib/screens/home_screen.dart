import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/screens/create_request_screen.dart';
import 'package:intl/intl.dart';
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
  // --- Состояние виджета ---
  int _selectedIndex = 0;
  List<RequestModel> _requests = [];
  bool _isLoading = true;

  static const List<String> _appBarTitles = <String>[
    'Доступные сервисы',
    'Мои заявки',
    'Льготы и программы',
    'Мой профиль'
  ];

  // --- Жизненный цикл ---
  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  // --- Методы для работы с данными ---

  /// Загружает список заявок из локального хранилища.
  Future<void> _loadRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final String? requestsString = prefs.getString('requests_data');
    List<RequestModel> loadedRequests = [];

    if (requestsString != null) {
      final List<dynamic> requestsJson = jsonDecode(requestsString);
      loadedRequests = requestsJson.map((json) => RequestModel.fromJson(json)).toList();
    }

    // Обновляем состояние один раз после всех операций
    setState(() {
      _requests = loadedRequests;
      _isLoading = false;
    });
  }

  /// Сохраняет текущий список заявок в локальное хранилище.
  Future<void> _saveRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final String requestsString = jsonEncode(_requests.map((r) => r.toJson()).toList());
    await prefs.setString('requests_data', requestsString);
  }

  /// Добавляет новую заявку в начало списка.
  void _addRequest(ServiceModel service) {
    // Создаем форматтер для даты в виде "день.месяц.год"
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    // Получаем текущую дату и форматируем ее в нужную строку
    final String formattedDate = formatter.format(DateTime.now());

    setState(() {
      _requests.insert(
        0,
        RequestModel(
          title: service.title,
          date: formattedDate, // <-- ИСПОЛЬЗУЕМ РЕАЛЬНУЮ ДАТУ
          status: RequestStatus.pending,
        ),
      );
    });
    _saveRequests();
  }

  /// Удаляет заявку из списка по ее ID.
  void _deleteRequest(String id) {
    final requestToRemove = _requests.firstWhere((req) => req.id == id);

    setState(() {
      _requests.remove(requestToRemove);
    });
    _saveRequests();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Заявка "${requestToRemove.title}" удалена.'),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  // --- Методы для навигации и UI ---

  /// Обрабатывает нажатие на сервис и открывает экран подтверждения.
  void _onServiceTap(ServiceModel service) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CreateRequestScreen(service: service),
      ),
    );

    if (result == true) {
      _addRequest(service);
      _onItemTapped(1); // Переключаемся на экран "Мои заявки"

      // Даем пользователю понятную обратную связь
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Заявка "${service.title}" успешно создана!'),
          backgroundColor: Colors.green[700],
        ),
      );
    }
  }

  /// Обрабатывает нажатие на элемент в нижней панели навигации.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Определяем, какой экран показывать в зависимости от выбранного индекса
    final List<Widget> widgetOptions = <Widget>[
      ServicesScreen(onServiceTap: _onServiceTap),
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RequestsScreen(
              requests: _requests,
              onDeleteRequest: _deleteRequest, // <-- ИСПРАВЛЕНО
            ),
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