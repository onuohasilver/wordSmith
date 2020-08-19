import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/cards.dart';
import 'package:wordsmith/components/cardComponents/singleEntryCard.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/components/inputComponents/buttons/draggableAlphabets.dart';
import 'package:wordsmith/components/widgetContainers/placeholder.dart';
import 'package:wordsmith/components/widgetContainers/progressBar.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/alphabetWidgetFunction.dart';
import 'package:wordsmith/core/utilities/alphabetTile.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';
import 'dart:collection';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/localData.dart';
import 'package:wordsmith/core/utilities/words.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
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
  List<Widget> alphabetWidget = [];
  final alphabetHandler = Alphabet().createState();
  // MappedLetters letterMap;
  // GamePlayData gamePlay;
  @override
  void initState() {
    super.initState();
    entryHandler = EntryHandler(wordGenerator: Words(index: widget.wordIndex));

    gameWord = entryHandler.wordGenerator.allAlphabets();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    GamePlayData gamePlay = Provider.of<GamePlayData>(context, listen: false);
    gamePlay.setupLetterMap(entryHandler);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  Animation animation;
  AnimationController animationController;
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AppThemeData theme = Provider.of<AppThemeData>(context);
    GamePlayData gamePlay = Provider.of<GamePlayData>(context);
    List<Widget> alphabetWidget = [];
    generateWidgets(
      alphabetWidget: alphabetWidget,
      entryHandler: entryHandler,
      gamePlay: gamePlay,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: theme.background,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  blurBox,
                  SizedBox(height: height * .01),
                  ProgressBar(height: height, width: width, progress: progress),
                  SizedBox(
                    height: height * .01,
                  ),
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
                              child: AnimatedList(
                            key: listKey,
                            // reverse:true,
                            initialItemCount: entryHandler.entryList.length,
                            itemBuilder: (BuildContext context, int index,
                                Animation animation) {
                              List listItems = entryHandler.entryList;
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                    parent: animation,
                                    curve: Interval(0.5, 1.0)),
                                child: SizeTransition(
                                  sizeFactor: CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.bounceInOut),
                                  child: ScaleTransition(
                                    scale: CurvedAnimation(
                                        parent: animation,
                                        curve: Interval(0.2, 1.0)),
                                    child: SinglePlayerEntryCard(
                                        key: ValueKey(listItems[index][1]),
                                        correct: listItems[index][0],
                                        entry: listItems[index][1]),
                                  ),
                                ),
                              );
                            },
                            reverse: true,
                            shrinkWrap: true,
                          ))
                        ],
                      ),
                    ),
                  ),
                  PlaceHolder(
                    entryHandler: entryHandler,
                    letterMap: gamePlay.letterMap,
                    gameWord: gameWord,
                    listKey: listKey,
                    gamePlay: gamePlay,
                    animationController: animationController,
                    dragTargetTrigger: (alphabetDetail) {
                      setState(() {
                        if (gamePlay.letterMap.map1.keys
                                .contains(alphabetDetail.alphabet) &
                            gamePlay.letterMap.map1[alphabetDetail.alphabet]) {
                          gamePlay.letterMap.map1[alphabetDetail.alphabet]
                              ? entryHandler.alphabetHandler.newAlpha
                                  .add(alphabetDetail.alphabet)
                              : print('inactive');
                          gamePlay.letterMap.map1[alphabetDetail.alphabet] =
                              false;
                        } else {
                          gamePlay.letterMap.map2[alphabetDetail.alphabet]
                              ? entryHandler.alphabetHandler.newAlpha
                                  .add(alphabetDetail.alphabet)
                              : print('inactive');
                          gamePlay.letterMap.map2[alphabetDetail.alphabet] =
                              false;
                        }
                      });
                    },
                    leftButtonTap: () {
                      entryHandler.alphabetHandler.reset();
                      gamePlay.letterMap.reset();
                    },
                    rightButtonTap: () {
                      setState(
                        () {
                          String allAlphabets =
                              entryHandler.alphabetHandler.allAlphabets();
                          entryHandler.alphabetHandler.reset();
                          gamePlay.letterMap.reset();
                          verifyWord(gameWord, allAlphabets)
                              ? progress = progress + 0.05
                              : progress = progress + 0;
                          bool criteria = allAlphabets.length >= 3;

                          criteria
                              ? entryHandler.insert(allAlphabets.trimLeft())
                              : Container();
                          criteria
                              ? listKey.currentState
                                  .insertItem(0, duration: Duration(seconds: 2))
                              : Container();
                          gamePlay.straightWins(entryHandler);
                          gamePlay.straightThree
                              ? animationController.repeat()
                              : animationController.reset();
                        },
                      );
                    },
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
          Center(
            child: AnimatedBuilder(
                animation: animation,
                builder: (context, widget) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: height * .7 * animation.value,
                        width: width * .7 * animation.value,
                        child: Image.asset('assets/stars.gif'),
                      ),
                      Container(
                        height: height * .7 * animation.value,
                        width: width * .8 * animation.value,
                        child: Image.asset(gamePlay.straightFive
                            ? 'assets/magnificient.gif'
                            : 'assets/magnificient.gif'),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    entryHandler = EntryHandler();
    animationController.dispose();
    super.dispose();
  }
}
