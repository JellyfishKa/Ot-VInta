// Необходим для jsonEncode/jsonDecode

// Enum для статусов остался без изменений
enum RequestStatus {
  approved('Одобрено'),
  inProgress('В работе'),
  rejected('Отклонено'),
  pending('Ожидание');

  const RequestStatus(this.displayName);
  final String displayName;
}

class RequestModel {
  final String id; // Добавляем уникальный ID
  final String title;
  final String date;
  final RequestStatus status;

  RequestModel({
    required this.title,
    required this.date,
    required this.status,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(); // Генерируем ID на основе времени

  // НОВЫЙ МЕТОД: Превращает объект RequestModel в Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'status': status.name, // Сохраняем имя enum, например 'approved'
    };
  }

  // НОВЫЙ КОНСТРУКТОР: Создает объект RequestModel из Map<String, dynamic>
  RequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        date = json['date'],
        status = RequestStatus.values.firstWhere((e) => e.name == json['status']);
}