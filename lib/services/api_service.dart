import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_manager_app/models/task.dart';

class ApiService {
  static String baseUrl = 'http://localhost:8080';

  static Future<Task> createTask(String token, String title, String description) async {
    final url = Uri.parse('$baseUrl/api/tasks');
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'title': title, 'description': description}),
    );

    if (resp.statusCode == 201 || resp.statusCode == 200) {
      return Task.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to create task: ${resp.statusCode}');
    }
  }

  static Future<void> deleteTask(String token, int id) async {
    final url = Uri.parse('$baseUrl/api/tasks/$id');
    final resp = await http.delete(url, headers: {'Authorization': 'Bearer $token'});
    if (resp.statusCode != 204 && resp.statusCode != 200) {
      throw Exception('Failed to delete task: ${resp.statusCode}');
    }
  }

  static Future<List<Task>> fetchTasks(String token) async {
    final url = Uri.parse('$baseUrl/api/tasks');
    final resp = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (resp.statusCode == 200) {
      final list = jsonDecode(resp.body) as List;
      return list.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch tasks: ${resp.statusCode}');
    }
  }

  static Future<String> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body);
      if (body['token'] != null) return body['token'];
      if (body['jwt'] != null) return body['jwt'];
      if (body['accessToken'] != null) return body['accessToken'];
      throw Exception('Token not found in response: ${resp.body}');
    } else {
      throw Exception('Login failed: ${resp.statusCode}');
    }
  }
}
