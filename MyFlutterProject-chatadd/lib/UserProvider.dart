import 'package:flutter/material.dart';
import 'package:myflutterproject/User.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  void logIn(User user) {
    _user = user;
    notifyListeners();
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}