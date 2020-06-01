import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
import 'package:wordsmith/components/displayComponents/buttons/alphabets.dart';
import 'dart:collection';
import 'package:wordsmith/utilities/alphabetTile.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/components/displayComponents/popUps/dialogBox.dart';
import 'package:wordsmith/utilities/words.dart';

class SingleLevelOne extends StatefulWidget {
  @override
  _SingleLevelOneState createState() => _SingleLevelOneState();
}

class _SingleLevelOneState extends State<SingleLevelOne> {
  EntryHandler entryHandler;

  final alphabetHandler = Alphabet().createState();
  MappedLetters letterMap;

  void initState() {
    super.initState();
   
    
    entryHandler = EntryHandler(wordGenerator: Words(index: 3));
    letterMap = MappedLetters(alphabets: entryHandler.getWord());

    startTimer();
    letterMap.getMapping();
  }

  int counter = 10;
  Timer timer;

  void startTimer() {
    counter = 10;

    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
          dialogBox(context, entryHandler.scoreKeeper.scoreValue().toString(),
              'SingleLevelTwo');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> alphabetWidget = [];
    final appData = Provider.of<Data>(context);
    

    generateWidgets() {
      for (var alphabet in letterMap.map1.keys) {
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
    }

    generateWidgets();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: appData.theme,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: LittleCard(
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                      onTap: () {
                        Navigator.popAndPushNamed(context, 'LevelSelect');
                      },
                    ),
                    LittleCard(
                      child: Text(
                        entryHandler.scoreKeeper.scoreValue().toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    LittleCard(
                      child: (counter > 7)
                          ? Text(
                              '$counter',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )
                          : Text(
                              "$counter",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 20),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: ListView(
                                reverse: false,
                                shrinkWrap: true,
                                children: UnmodifiableListView(
                                    entryHandler.entryList)))
                      ],
                    ),
                  ),
                ),
                Card(
                    color: Colors.lightBlue.withOpacity(.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            child: Icon(Icons.delete_forever,
                                color: Colors.lightBlue, size: 30.0),
                            onTap: () {
                              setState(
                                () {
                                  entryHandler.alphabetHandler.reset();
                                  letterMap.reset();
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                                entryHandler.alphabetHandler.newAlpha
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            child: Icon(Icons.send,
                                color: Colors.lightBlue, size: 30.0),
                            onTap: () {
                              setState(
                                () {
                                  String allAlphabets = entryHandler
                                      .alphabetHandler
                                      .allAlphabets();
                                  bool criteria = allAlphabets.length > 3;
                                  entryHandler.alphabetHandler.reset();
                                  criteria
                                      ? entryHandler
                                          .insert(allAlphabets.trimLeft())
                                      : print('');
                                  letterMap.reset();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: alphabetWidget,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    entryHandler = EntryHandler();
    super.dispose();
  }
}
