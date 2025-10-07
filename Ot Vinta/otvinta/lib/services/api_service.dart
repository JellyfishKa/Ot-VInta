import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Импортируем модели данных
import '../models/request_model.dart';
import '../models/service_model.dart';
import '../models/benefit_model.dart';

class ApiService {

  // --- 1. ЗАГРУЗКА КОНФИГУРАЦИИ ИЗ .env ФАЙЛА ---
  // Больше никаких "вшитых" значений. Все берется из .env файла.
  final String _baseUrl = dotenv.env['BASE_URL']!;
  final String _token = dotenv.env['API_TOKEN']!;
  final String _servicesPath = dotenv.env['SERVICES_PATH']!;
  final String _benefitsPath = dotenv.env['BENEFITS_PATH']!;
  final String _requestsPath = dotenv.env['REQUESTS_PATH']!;


  /// Возвращает заголовки для всех HTTP-запросов.
  /// Использует токен, загруженный из .env файла.
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $_token',
    };
  }

  /// Загружает список доступных услуг с сервера.
  Future<List<ServiceModel>> fetchServices() async {
    // --- 2. ФОРМИРОВАНИЕ URL ---
    // Собираем полный URL из базового адреса и пути к ресурсу.
    // Это исправляет ошибку 404.
    final url = Uri.parse('$_baseUrl$_servicesPath');
      // --- НАЧАЛО ВРЕМЕННОГО КОДА ДЛЯ ОТЛАДКИ ---
    print('--- DEBUG ---');
    print('Полный URL запроса: $url');
    print('Используемый токен: $_token');
    print('--- END DEBUG ---');
    // --- КОНЕЦ ВРЕМЕННОГО КОДА ДЛЯ ОТЛАДКИ ---
    final response = await http.get(url, headers: _getHeaders());
    
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((json) => ServiceModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки сервисов: ${response.statusCode}, Body: ${response.body}');
    }
  }

  /// Загружает список доступных льгот с сервера.
  Future<List<BenefitModel>> fetchBenefits() async {
    final url = Uri.parse('$_baseUrl$_benefitsPath');
    final response = await http.get(url, headers: _getHeaders());
    
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((json) => BenefitModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки льгот: ${response.statusCode}, Body: ${response.body}');
    }
  }
  
  /// Загружает список заявок пользователя.
  Future<List<RequestModel>> fetchRequests() async {
    final url = Uri.parse('$_baseUrl$_requestsPath');
    final response = await http.get(url, headers: _getHeaders());
    
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((dynamic item) => RequestModel.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка загрузки заявок: ${response.statusCode}, Body: ${response.body}');
    }
  }
  
  /// Отправляет запрос на создание новой заявки.
  Future<RequestModel> createRequest(String serviceId) async {
    final url = Uri.parse('$_baseUrl$_requestsPath');
    
    // --- ИЗМЕНЕНИЕ: Мы отправляем не просто строку, а число, как ждет сервер ---
    final body = jsonEncode({'service': int.parse(serviceId)});
    // ------------------------------------------------------------------------

    final response = await http.post(
      url,
      headers: _getHeaders(),
      body: body,
    );

    if (response.statusCode == 201) {
        final dynamic responseBody = json.decode(utf8.decode(response.bodyBytes));
        return RequestModel.fromJson(responseBody);
    } else {
        // --- КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Печатаем ответ сервера в консоль ---
        print('--- ОШИБКА СОЗДАНИЯ ЗАЯВКИ ---');
        print('Статус код: ${response.statusCode}');
        print('Тело ответа: ${response.body}');
        print('-----------------------------');
        // -----------------------------------------------------------
        throw Exception('Ошибка создания заявки: ${response.body}');
    }
  }
  
  /// Загружает детальную информацию по одной заявке по ее ID.
  Future<RequestModel> fetchRequestById(String id) async {
    // Добавляем ID и слэш в конец пути
    final url = Uri.parse('$_baseUrl$_requestsPath$id/'); 
    final response = await http.get(url, headers: _getHeaders());

    if (response.statusCode == 200) {
      final dynamic body = json.decode(utf8.decode(response.bodyBytes));
      return RequestModel.fromJson(body);
    } else {
      throw Exception('Ошибка загрузки заявки с ID $id. Код: ${response.statusCode}');
    }
  }
  
  /// Удаляет заявку по ее ID.
  Future<void> deleteRequest(String id) async {
    final url = Uri.parse('$_baseUrl$_requestsPath$id/');
    
    final response = await http.delete(url, headers: _getHeaders());

    if (response.statusCode != 204) { // 204 No Content - успешное удаление
      throw Exception('Не удалось удалить заявку. Код ответа: ${response.statusCode}');
    }
  }
}