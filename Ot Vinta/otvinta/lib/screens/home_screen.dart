import 'package:flutter/material.dart';
import 'package:otvinta/models/request_model.dart';
import 'package:otvinta/models/service_model.dart';
import 'package:otvinta/screens/create_request_screen.dart';
import 'package:otvinta/services/api_service.dart';
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
  final ApiService _apiService = ApiService();

  int _selectedIndex = 0;
  List<RequestModel> _requests = [];
  bool _isLoading = true;

  static const List<String> _appBarTitles = <String>[
    'Доступные сервисы',
    'Мои заявки',
    'Льготы и программы',
    'Мой профиль'
  ];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      final loadedRequests = await _apiService.fetchRequests();
      if (mounted) {
        setState(() {
          _requests = loadedRequests;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки заявок: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _addRequest(ServiceModel service) async {
    try {
      final newRequestFromServer = await _apiService.createRequest(service.id);
      setState(() {
        _requests.insert(0, newRequestFromServer);
      });
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Заявка "${service.title}" успешно создана!'),
            backgroundColor: Colors.green[700],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка создания заявки: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _deleteRequest(String id) async {
    final requestToRemove = _requests.firstWhere((req) => req.id == id);
    final index = _requests.indexOf(requestToRemove);

    setState(() {
      _requests.removeAt(index);
    });

    try {
      await _apiService.deleteRequest(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Заявка "${requestToRemove.title}" удалена.')),
        );
      }
    } catch (e) {
      setState(() {
        _requests.insert(index, requestToRemove);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка удаления: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _onServiceTap(ServiceModel service) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => CreateRequestScreen(service: service),
      ),
    );

    if (mounted && result == true) {
      await _addRequest(service);
      _onItemTapped(1); 
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- ВОССТАНОВЛЕННЫЙ МЕТОД BUILD ---
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ServicesScreen(onServiceTap: _onServiceTap),
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RequestsScreen(
              requests: _requests,
              onDeleteRequest: _deleteRequest,
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