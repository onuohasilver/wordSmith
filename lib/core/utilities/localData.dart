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
    sharedPreferences.setStringList('LoginCred', [email, password]);
  }

  Future<List<String>> get loginCredentials async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> loginCredential = sharedPreferences.getStringList('LoginCred');
    return loginCredential;
  }

  Future<void> saveActiveLevels(String level) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      List<String> activeLevel =
          sharedPreferences.getStringList('activeLevels');
      activeLevel.add(level);
      sharedPreferences.setStringList('activeLevels', activeLevel);
    } catch (e) {
      sharedPreferences.setStringList('activeLevels', [level]);
    }
  }

  Future<List<String>> get activeLevels async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> activeLevel = sharedPreferences.getStringList('activeLevels');
    return activeLevel;
  }
}
