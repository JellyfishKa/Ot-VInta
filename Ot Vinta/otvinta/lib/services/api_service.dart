import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/request_model.dart';
import '../models/service_model.dart';
import '../models/benefit_model.dart';

class ApiService {
  final String _baseUrl = dotenv.env['BASE_URL']!;
  final String _token = dotenv.env['API_TOKEN']!;
  final String _servicesPath = dotenv.env['SERVICES_PATH']!;
  final String _benefitsPath = dotenv.env['BENEFITS_PATH']!;
  final String _requestsPath = dotenv.env['REQUESTS_PATH']!;
  final String _profilePath = '/api/users/me/';
  final String _deleteRequestPath = dotenv.env['DELETE_REQUEST_PATH']!;

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $_token',
    };
  }

  Future<List<ServiceModel>> fetchServices() async {
    final url = Uri.parse('$_baseUrl$_servicesPath');
    final response = await http.get(url, headers: _getHeaders());
    
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((json) => ServiceModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки сервисов: ${response.statusCode}, Body: ${response.body}');
    }
  }

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
  
  Future<RequestModel> createRequest(String serviceId) async {
    final url = Uri.parse('$_baseUrl$_requestsPath');
    final body = jsonEncode({'service': int.parse(serviceId)});

    final response = await http.post(
      url,
      headers: _getHeaders(),
      body: body,
    );

    if (response.statusCode == 201) {
        final dynamic responseBody = json.decode(utf8.decode(response.bodyBytes));
        return RequestModel.fromJson(responseBody);
    } else {
        throw Exception('Ошибка создания заявки: ${response.body}');
    }
  }
  
  // --- ИЗМЕНЕНО: Исправление логики удаления ---
  Future<void> deleteRequest(int id) async { 
    final url = Uri.parse('$_baseUrl$_requestsPath$id/delete'); 
    final response = await http.delete(url, headers: _getHeaders());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 204) { 
      throw Exception('Не удалось удалить заявку. Код ответа: ${response.statusCode}, Тело: ${response.body}');
    }
  }
}