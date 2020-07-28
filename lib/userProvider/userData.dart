import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  String email;
  String password;
  String userName;
  bool progressComplete = false;
  String gameID;
  String opponentGameID;
  String challengerGameID;
  ///Current User ID as attached to firestore.
  String currentUserID;
  BoxDecoration theme = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xff000e54), Color(0xff2a4299)],
      stops: [0.2, 1],
    ),
  );

  updateUserID(String userID){
    currentUserID=userID;
    notifyListeners();
  }

  updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  updateProgress() {
    progressComplete = !progressComplete;
    notifyListeners();
  }

  updateUserName(String newUserName) {
    userName = newUserName;
    notifyListeners();
  }

  updateGameID(String newGameID) {
    gameID = newGameID;
    challengerGameID = gameID.split('').reversed.join();
    opponentGameID = gameID;
    notifyListeners();
  }

  updateTheme(BoxDecoration newTheme) {
    theme = newTheme;
    notifyListeners();
  }
}
