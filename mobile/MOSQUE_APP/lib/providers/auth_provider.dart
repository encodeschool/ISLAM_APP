import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user/user.dart';
import '../service/auth_service.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();

  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;

  bool get isLoggedIn => _token != null;

  Future<void> loadUser() async {

    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString("token");

    final userJson = prefs.getString("user");

    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }

    notifyListeners();
  }

  Future<bool> login(String email, String password) async {

    try {

      final response = await _authService.login(email, password);

      _token = response["token"];
      _user = User.fromJson(response["user"]);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", _token!);
      await prefs.setString(
        "user",
        jsonEncode(_user!.toJson()),
      );

      notifyListeners();

      return true;

    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String email, String password, String name) async {

    try {

      final response = await _authService.register(email, password, name);

      _token = response["token"];
      _user = User.fromJson(response["user"]);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", _token!);
      await prefs.setString(
        "user",
        jsonEncode(_user!.toJson()),
      );

      notifyListeners();

      return true;

    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    await prefs.remove("user");

    _token = null;
    _user = null;

    notifyListeners();
  }
}