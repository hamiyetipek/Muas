import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int _userId = 0;
  String _userName = "";

  int get userId => _userId;
  String get userName => _userName;

  void setUser(int id, String name) {
    _userId = id;
    _userName = name;
    notifyListeners();
  }
}