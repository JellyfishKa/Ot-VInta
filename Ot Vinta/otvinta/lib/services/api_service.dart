import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request_model.dart';
import '../models/service_model.dart';
import '../models/benefit_model.dart';

class ApiService {
  final String _baseUrl = "https://your-django-api.com/api";

  Future<String?> _getToken() async {
    return null;
   /* ... */ }
  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    if (token == null) {
      // Если токена нет, последующие запросы не должны выполняться
      throw Exception('Пользователь не авторизован');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  Future<void> login(String email, String password) async { /* ... */ }

  Future<List<ServiceModel>> fetchServices() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$_baseUrl/services/'), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((json) => ServiceModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки сервисов: ${response.statusCode}');
    }
  }

  Future<List<BenefitModel>> fetchBenefits() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$_baseUrl/benefits/'), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((json) => BenefitModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки льгот: ${response.statusCode}');
    }
  }
  
  Future<List<RequestModel>> fetchRequests() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$_baseUrl/requests/'), headers: headers);
    if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
        return body.map((dynamic item) => RequestModel.fromJson(item)).toList();
      } else {
        throw Exception('Ошибка загрузки заявок: ${response.statusCode}');
      }
  }
  
  Future<RequestModel> createRequest(String serviceId) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$_baseUrl/requests/'),
      headers: headers,
      body: jsonEncode({'service_id': serviceId}),
    );
     if (response.statusCode == 201) {
        final dynamic body = json.decode(utf8.decode(response.bodyBytes));
        return RequestModel.fromJson(body);
      } else {
        throw Exception('Ошибка создания заявки: ${response.body}');
      }
  }
  
  Future<RequestModel> fetchRequestById(String id) async {
  final headers = await _getHeaders();
  final response = await http.get(
    Uri.parse('$_baseUrl/requests/$id/'), 
    headers: headers
  );
  if (response.statusCode == 200) {
    final dynamic body = json.decode(utf8.decode(response.bodyBytes));
    return RequestModel.fromJson(body);
  } else {
    throw Exception('Ошибка загрузки заявки с ID $id');
  }
  }
  
  Future<void> deleteRequest(String id) async {
    throw Exception('Функция удаления еще не реализована на сервере.');
  }
}