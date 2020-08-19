import 'package:flutter/widgets.dart';
import 'package:wordsmith/components/inputComponents/buttons/draggableAlphabets.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:meta/meta.dart';

generateWidgets(
    {@required List<Widget> alphabetWidget,
    @required GamePlayData gamePlay,
    @required EntryHandler entryHandler}) {
  for (var alphabet in gamePlay.letterMap.map1.keys) {
    alphabetWidget.add(DraggableAlphabet(
      alphabet: alphabet,
      active: gamePlay.letterMap.map1[alphabet],
      onPressed: () {
        gamePlay.letterMap.map1[alphabet]
            ? entryHandler.alphabetHandler.newAlpha.add(alphabet)
            : print('inactive');
        gamePlay.letterMap.map1[alphabet] = false;
      },
    ));
  }
  for (var alphabet in gamePlay.letterMap.map2.keys) {
    alphabetWidget.add(DraggableAlphabet(
      alphabet: alphabet,
      active: gamePlay.letterMap.map2[alphabet],
      onPressed: () {
        gamePlay.letterMap.map2[alphabet]
            ? entryHandler.alphabetHandler.newAlpha.add(alphabet)
            : print('inactive');
        gamePlay.letterMap.map2[alphabet] = false;
      },
    ));
  }
}
