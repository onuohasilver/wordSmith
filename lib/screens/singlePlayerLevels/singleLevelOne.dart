import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/cards.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/components/widgetContainers/progressBar.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/utilities/alphabetTile.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';
import 'dart:collection';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/localData.dart';
import 'package:wordsmith/core/utilities/words.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/screens/popUps/dialogs/dialogBox.dart';

class SingleLevelOne extends StatefulWidget {
  final int wordIndex;

  const SingleLevelOne({Key key, @required this.wordIndex}) : super(key: key);
  @override
  _SingleLevelOneState createState() => _SingleLevelOneState();
}

class _SingleLevelOneState extends State<SingleLevelOne>
    with SingleTickerProviderStateMixin {
  EntryHandler entryHandler;
  String gameWord;

  final alphabetHandler = Alphabet().createState();
  MappedLetters letterMap;

  void initState() {
    super.initState();
    entryHandler = EntryHandler(wordGenerator: Words(index: widget.wordIndex));
    letterMap = MappedLetters(alphabets: entryHandler.getWord());
    gameWord = entryHandler.wordGenerator.allAlphabets();
    // startTimer();
    letterMap.getMapping();
  }

  int counter = 10;
  double progress = 0;
  Timer timer;
  LocalData localData = LocalData();
  int highScore = 0;
  void getHighScore() async {
    final _highScore = await localData.highScore;
    setState(() {
      highScore = _highScore;
    });
  }

  // void startTimer() {
  //   counter = 50;

  //   if (timer != null) {
  //     timer.cancel();
  //   }
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (counter > 0) {
  //         counter--;
  //       } else {
  //         timer.cancel();
  //         final currentScore = entryHandler.scoreKeeper.scoreValue();
  //         getHighScore();
  //         if (highScore < currentScore) {
  //           localData.setHighScore(currentScore);
  //         }

  //         dialogBox(context, currentScore.toString(), 'SingleLevelTwo');
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> alphabetWidget = [];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AppThemeData theme = Provider.of<AppThemeData>(context);

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
    return Scaffold(
      body: Container(
        decoration: theme.background,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              blurBox,
              SizedBox(
                height: height * .01
              ),
              // Text(progress.toString()),
              ProgressBar(height: height, width: width, progress: progress),
              SizedBox(
                height: height * .01,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     GestureDetector(
              //       child: LittleCard(
              //           child: Icon(Icons.arrow_back, color: Colors.white)),
              //       onTap: () {
              //         Navigator.popAndPushNamed(context, 'LevelSelect');
              //       },
              //     ),
              //     LittleCard(
              //       child: Text(
              //         entryHandler.scoreKeeper.scoreValue().toString(),
              //         style: TextStyle(fontSize: 20, color: Colors.white),
              //       ),
              //     ),
              //     LittleCard(
              //       child: (counter > 7)
              //           ? Text(
              //               '$counter',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 20,
              //                   color: Colors.white),
              //             )
              //           : Text(
              //               "$counter",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.red,
              //                   fontSize: 20),
              //             ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Card(
                  color: Colors.white.withOpacity(.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: ListView(
                              reverse: false,
                              shrinkWrap: true,
                              children:
                                  UnmodifiableListView(entryHandler.entryList)))
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage('assets/pngwave.png'),
                    //         fit: BoxFit.fitWidth)),
                    color: Colors.white.withOpacity(.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            child: Icon(Icons.delete_forever,
                                color: Colors.red[800], size: 30.0),
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
                                color: Colors.brown[800], size: 30.0),
                            onTap: () {
                              setState(
                                () {
                                  String allAlphabets = entryHandler
                                      .alphabetHandler
                                      .allAlphabets();
                                  verifyWord(gameWord, allAlphabets)
                                      ? progress = progress + 0.05
                                      : progress = progress + 0;
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
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: alphabetWidget,
              ),
            ],
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

