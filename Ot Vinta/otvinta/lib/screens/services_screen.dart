import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../services/api_service.dart'; 

// Экран теперь является StatefulWidget, чтобы управлять состоянием загрузки данных
class ServicesScreen extends StatefulWidget {
  final Function(ServiceModel) onServiceTap;

  const ServicesScreen({super.key, required this.onServiceTap});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // 2. СОЗДАЕМ ПЕРЕМЕННЫЕ ДЛЯ ЗАГРУЗКИ ДАННЫХ
  // Future будет хранить результат асинхронной операции загрузки
  late Future<List<ServiceModel>> _servicesFuture;
  // Создаем экземпляр нашего сервиса для выполнения запросов
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // 3. ЗАПУСКАЕМ ЗАГРУЗКУ ДАННЫХ ПРИ СТАРТЕ ЭКРАНА
    // Присваиваем нашей Future результат вызова метода из ApiService
    _servicesFuture = _apiService.fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    // 4. ИСПОЛЬЗУЕМ FutureBuilder ДЛЯ ОТОБРАЖЕНИЯ РАЗНЫХ СОСТОЯНИЙ
    // Он автоматически перерисовывает UI в зависимости от состояния Future
    return FutureBuilder<List<ServiceModel>>(
      future: _servicesFuture, // Указываем, за какой Future следить
      builder: (context, snapshot) {
        
        // Состояние 1: Загрузка еще идет
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Состояние 2: Произошла ошибка
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Ошибка загрузки услуг: ${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Состояние 3: Данные успешно загружены, но список пуст
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Доступные услуги отсутствуют.'));
        }

        // Состояние 4: Успех! Данные есть, рисуем список
        final services = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12.0),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                // Теперь иконка статична, т.к. с бэкенда она не приходит
                leading: Icon(Icons.apps, color: Theme.of(context).primaryColor, size: 30),
                title: Text(service.title),
                subtitle: Text(service.category ?? ''), // Показываем категорию
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  // Вызываем callback с объектом, полученным с сервера (у него есть ID)
                  widget.onServiceTap(service);
                },
              ),
            );
          },
        );
      },
    );
  }
}