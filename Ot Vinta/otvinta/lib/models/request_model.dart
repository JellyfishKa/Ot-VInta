enum RequestStatus {
  approved('Одобрено'),
  inProgress('В работе'),
  rejected('Отклонено'),
  pending('Ожидание');

  const RequestStatus(this.displayName);
  final String displayName;
  
  // Вспомогательный метод для получения статуса из строки от бэкенда
  static RequestStatus fromString(String statusString) {
    return RequestStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == statusString.toLowerCase(),
      orElse: () => RequestStatus.pending, // Значение по умолчанию, если статус не найден
    );
  }
}

class RequestModel {
  final String id; // ID теперь обязателен и приходит с сервера
  final String title;
  final String date; 
  final RequestStatus status;

  RequestModel({
    required this.id, // <-- Изменено
    required this.title,
    required this.date,
    required this.status,
  }); // Генерацию ID убрали

  // toJson нужен, только если мы отправляем ПОЛНУЮ модель на сервер. 
  // Обычно для создания мы отправляем другой набор полей (например, только service_id).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date, // Убедитесь, что отправляете в формате, который ждет сервер
      'status': status.name,
    };
  }

  factory RequestModel.fromJson(Map<String, dynamic> json) {

    return RequestModel(
      id: json['id'].toString(), // Преобразуем в строку на всякий случай
      title: json['title'],
      date: json['date'], // Или используйте formattedDate, если парсите дату
      status: RequestStatus.fromString(json['status']),
    );
  }
}