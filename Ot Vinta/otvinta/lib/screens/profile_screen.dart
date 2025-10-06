import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Аватар пользователя
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'), // Используем сервис-заглушку для фото
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 16),
          // ФИО
          const Text(
            'Смирнов Алексей Петрович',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // Должность
          const Text(
            'Ведущий инженер-программист',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Разделитель
          const Divider(),
          const SizedBox(height: 16),
          // Карточка с информацией
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
             // Убираем лишние отступы у ListTile внутри Card
            margin: EdgeInsets.zero,
            child: const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.badge_outlined),
                  title: Text('Табельный номер'),
                  subtitle: Text('778-120-945'),
                ),
                ListTile(
                  leading: Icon(Icons.work_outline),
                  title: Text('Департамент'),
                  subtitle: Text('Отдел разработки мобильных приложений'),
                ),
                ListTile(
                  leading: Icon(Icons.alternate_email_outlined),
                  title: Text('Корпоративная почта'),
                  subtitle: Text('a.smirnov@otvinta.corp'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Кнопка выхода
          SizedBox(
            width: double.infinity, // Кнопка на всю ширину
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Выйти из аккаунта'),
              onPressed: () {
                // Здесь будет логика выхода из приложения
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Выполняется выход...')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}