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

  ///controller that tracks the number of validated items
  Map<String, List> controller = {
    'straightThree': [0, true],
    'straightFive': [0, true],
    'straightSeven': [0, true]
  };

  ///increase the controller count states
  void controllerUpdate({bool counter = false}) {
    if (counter) {
      straightThree
          ? controller['straightThree'][0] = 0
          : controller['straightThree'][0]++;
      straightFive
          ? controller['straightFive'][0] = 0
          : controller['straightFive'][0]++;
      straightSeven
          ? controller['straightSeven'][0] = 0
          : controller['straightSeven'][0]++;
    } else {
      controller['straightThree'][0]++;
      controller['straightFive'][0]++;
      controller['straightSeven'][0]++;
      controller['straightThree'][0] == 2
          ? controller['straightThree'][1] = true
          : controller['straightThree'][1] = false;
      controller['straightFive'][0] == 4
          ? controller['straightFive'][1] = true
          : controller['straightFive'][1] = false;
      controller['straightSeven'][0] == 6
          ? controller['straightSeven'][1] = true
          : controller['straightSeven'][1] = false;
    }
    notifyListeners();
  }

  /// update the state of the players number of correct entries
  void straightWins(EntryHandler entryHandler) {
    controllerUpdate(counter: true);
    List truthList = entryHandler.scoreKeeper.scoresTruthList;
    int tLength = truthList.length;

    ///check if the truthList contains at least three values
    if ((tLength > 2) & controller['straightThree'][1]) {
      List _tSubList = truthList.sublist(tLength - 3, tLength);
      straightThree = _tSubList.every((element) => element == true);
      controllerUpdate(counter: true);
    }
    if ((tLength > 4) & controller['straightFive'][1]) {
      List _tSubList = truthList.sublist(tLength - 5, tLength);
      straightFive = _tSubList.every((element) => element == true);
      controllerUpdate(counter: true);
    }
    if ((tLength > 6) & controller['straightSeven'][1]) {
      List _tSubList = truthList.sublist(tLength - 7, tLength);
      straightSeven = _tSubList.every((element) => element == true);
      controllerUpdate(counter: true);
    }
    Timer(
      Duration(milliseconds: 20),
      () {
        straightThree = false;
        straightFive = false;
        straightSeven = false;
      },
    );
    
    notifyListeners();
  }
}
