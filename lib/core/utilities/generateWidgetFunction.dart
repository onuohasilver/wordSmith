import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:meta/meta.dart';

class WidgetCreator {
  List<Widget> xWidget=[];
  List<Widget> getWidgets(){
    // print(xWidget);
    return xWidget;
  }
  generateWidgets(
      {@required alphabetWidget, @required letterMap, @required entryHandler}) {
        print(entryHandler);
    return StatefulBuilder(builder: (BuildContext context, setState) {
      for (var alphabet in letterMap.map1.keys) {
                print(alphabetWidget);
        alphabetWidget.add(AlphabetButton(
          alphabet: alphabet,
          active: letterMap.map1[alphabet],
          onPressed: () {
            setState(() {
              letterMap.map1[alphabet]
                  ? entryHandler.alphabetHandler.newAlpha.add(alphabet)
                  : print('inactive');
              letterMap.map1[alphabet] = false;
            });
          },
        ));
      }
      for (var alphabet in letterMap.map2.keys) {

        alphabetWidget.add(AlphabetButton(
          alphabet: alphabet,
          active: letterMap.map2[alphabet],
          onPressed: () {
            setState(() {
              letterMap.map2[alphabet]
                  ? entryHandler.alphabetHandler.newAlpha.add(alphabet)
                  : print('inactive');
              letterMap.map2[alphabet] = false;
            });
          },
        ));
      }
      xWidget=alphabetWidget;
      return alphabetWidget;
    });
  }
}
