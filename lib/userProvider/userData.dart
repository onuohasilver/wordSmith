import 'package:flutter/material.dart';
class Data extends ChangeNotifier {
  String email;
  String password;
  String userName;
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

  updateUserName(newUserName){
    userName=newUserName;
    notifyListeners();
  }
}