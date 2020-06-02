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

  
}
