class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String? patronymic; // Отчество может отсутствовать
  final String position;
  final String email;
  final String? employeeId; // Табельный номер
  final String? department;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.patronymic,
    required this.position,
    required this.email,
    this.employeeId,
    this.department,
    this.avatarUrl,
  });

  // Геттер для получения полного имени
  String get fullName {
    return '$lastName $firstName ${patronymic ?? ''}'.trim();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      patronymic: json['patronymic'],
      position: json['position'] ?? 'Должность не указана',
      email: json['email'] ?? 'Email не указан',
      employeeId: json['employee_id'],
      department: json['department'],
      avatarUrl: json['avatar'],
    );
  }

  static UserModel mock() {
    return UserModel(
      id: 1,
      firstName: 'Алексей',
      lastName: 'Смирнов',
      patronymic: 'Петрович',
      position: 'Ведущий инженер-программист',
      email: 'a.smirnov@otvinta.corp',
      employeeId: '778-120-945',
      department: 'Отдел разработки мобильных приложений',
      // Используем сервис-заглушку для фото, как в дизайне
      avatarUrl: 'https://i.pravatar.cc/150?img=12', 
    );
  }
}