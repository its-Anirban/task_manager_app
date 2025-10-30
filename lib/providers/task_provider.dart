import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/api_service.dart';

class TaskProvider extends ChangeNotifier {

  TaskProvider({this.token});
  String? token;
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    if (token == null) return;
    tasks = await ApiService.fetchTasks(token!);
    notifyListeners();
  }

  Future<void> addTask(String title, String description) async {
    if (token == null) return;
    final t = await ApiService.createTask(token!, title, description);
    tasks.insert(0, t);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    if (token == null) return;
    await ApiService.deleteTask(token!, id);
    tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
