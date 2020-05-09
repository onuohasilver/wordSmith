import 'package:flutter/material.dart';
class UserData extends ChangeNotifier {
  String email = 'asas';
  String password;
  updateEmail(newEmail) {
    email = newEmail;
    notifyListeners();
  }

  updatePassword(newPassword) {
    password = newPassword;
    notifyListeners();
  }
}