import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';

/// State management for actual gameplay
/// tracks the number of player fails/wins to trigger
/// a UI update
class GamePlayData extends ChangeNotifier {
  ///identifier that the user has made five straight entries
  bool straightFive = false;

  ///identifier that the user hase made three straight entries
  bool straightThree = false;

  ///identifier that the user has made seven straight entries
  bool straightSeven = false;

  ///identifier that the user has made two straight incorrect entries
  bool failTwo = false;

  /// update the state of the players number of correct entries
  void straightWins(EntryHandler entryHandler) {
    List truthList = entryHandler.scoreKeeper.scoresTruthList;
    int tLength = truthList.length;

    ///check if the truthList contains at least three values
    if (tLength > 2) {
      List _tSubList = truthList.sublist(tLength - 3, tLength);
      straightThree = _tSubList.every((element) => element == true);
    }
    if (tLength > 4) {
      List _tSubList = truthList.sublist(tLength - 5, tLength);
      straightFive = _tSubList.every((element) => element == true);
    }
    if (tLength > 6) {
      List _tSubList = truthList.sublist(tLength - 7, tLength);
      straightFive = _tSubList.every((element) => element == true);
    }
    Timer(
      Duration(milliseconds: 20),
      () {
        straightThree = false;
        straightFive = false;
        straightSeven= false;
      },
    );
    notifyListeners();
  }
}
