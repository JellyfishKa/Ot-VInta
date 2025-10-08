enum RequestStatus {
  approved('Одобрено'),
  inProgress('В работе'),
  rejected('Отклонено'),
  pending('Ожидание');

  const RequestStatus(this.displayName);
  final String displayName;
  
  static RequestStatus fromString(String? statusString) {
    if (statusString == null) return RequestStatus.pending;
    return RequestStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == statusString.toLowerCase(),
      orElse: () => RequestStatus.pending,
    );
  }
}

class RequestModel {
  final int id;
  final String title;
  final String date; 
  final RequestStatus status;

  // --- ДОБАВЛЕНО ПОЛЕ ДЛЯ ID СЕРВИСА ---
  final int serviceId;
  // ------------------------------------

  RequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.serviceId, // Добавлено в конструктор
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'status': status.name,
      'service': serviceId, // Используем serviceId
    };
  }

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      
      // --- ИСПРАВЛЕНИЕ: Просто берем title, который пришел ---
      // Сервер сам формирует название заявки, нам не нужно его конструировать.
      title: json['title'] ?? 'Заявка без названия',
      // --------------------------------------------------------

      // Используем поле 'created_at' от сервера для даты
      date: json['created_at'] ?? DateTime.now().toIso8601String(),
      status: RequestStatus.fromString(json['status']),
      
      // --- ИСПРАВЛЕНИЕ: Правильно читаем ID сервиса ---
      serviceId: json['service'] ?? 0, // 0 как значение по умолчанию, если ID не пришел
      // ------------------------------------------------
    );
  }
}