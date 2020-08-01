import 'package:flutter/material.dart';

class SoundData extends ChangeNotifier {

  bool playingBase = true;

  void stop() {
    playingBase = !playingBase;
    notifyListeners();
  }
}
