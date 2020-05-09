import 'package:flutter/material.dart';
class UserData extends ChangeNotifier {
  String email;
  String password;
  bool progressComplete=false;

  updateEmail(newEmail) {
    email = newEmail;
    notifyListeners();
  }

  updatePassword(newPassword) {
    password = newPassword;
    notifyListeners();
  }

  updateProgress(){
    progressComplete=!progressComplete;
    notifyListeners();
  }
}