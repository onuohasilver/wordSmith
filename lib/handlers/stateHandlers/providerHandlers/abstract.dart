import 'package:flutter/cupertino.dart';

class AbstractData extends ChangeNotifier {
  int counter = 5;
  bool display = false;

  void resetCounter({int counterD}) {
    counter = counterD != null ? counterD : 5;
    notifyListeners();
  }

  void setDisplay(bool value) {
    display = value;
    notifyListeners();
  }

  void reduceCounter() {
    counter--;
    notifyListeners();
  }
}
