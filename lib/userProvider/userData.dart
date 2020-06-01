import 'package:flutter/material.dart';
class Data extends ChangeNotifier {
  String email;
  String password;
  String userName;
  bool progressComplete=false;
  String gameID;
  String opponentGameID;
  String challengerGameID;
  BoxDecoration theme;

  updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  updateProgress(){
    progressComplete=!progressComplete;
    notifyListeners();
  }

  updateUserName(String newUserName){
    userName=newUserName;
    notifyListeners();
  }

  updateGameID(String newGameID){
    gameID=newGameID;
    challengerGameID=gameID.split('').reversed.join();
    opponentGameID=gameID;
    notifyListeners();
  }
  updateTheme(BoxDecoration newTheme){
    theme=newTheme;
    notifyListeners();

  }
}