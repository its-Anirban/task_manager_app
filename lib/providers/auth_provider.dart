import 'package:flutter/material.dart';
import 'package:task_manager_app/services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  bool get isLoggedIn => token != null;

  Future<void> login(String username, String password) async {
    token = await ApiService.login(username, password);
    notifyListeners();
  }

  void logout() {
    token = null;
    notifyListeners();
  }
}
