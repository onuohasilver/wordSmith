import 'package:flutter/material.dart';
class Data extends ChangeNotifier {
  String email;
  String password;
  String userName;
  bool progressComplete=false;
  String gameID;
  String opponentGameID;
  String challengerGameID;
  

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

  updateGameID(newGameID){
    gameID=newGameID;
    challengerGameID=gameID.split('').reversed.join();
    opponentGameID=gameID;
    notifyListeners();
  }
}