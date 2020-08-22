import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<void> setHighScore(int highScore) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('HighScore', highScore);
  }

  Future<int> get highScore async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int highScore = sharedPreferences.getInt('HighScore');
    return highScore;
  }

  Future<void> saveLoginCredentials(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('Email', [email, password]);
  }

  Future<List<String>> get loginCredentials async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> loginCredential = sharedPreferences.getStringList('Email');
    return loginCredential;
  }

}
