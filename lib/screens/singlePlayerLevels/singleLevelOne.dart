import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/singleEntryCard.dart';
import 'package:wordsmith/components/widgetContainers/placeholder.dart';
import 'package:wordsmith/components/widgetContainers/progressBar.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/alphabetWidgetFunction.dart';

import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';

import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/localData.dart';
import 'package:wordsmith/core/utilities/words.dart';

import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';

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

  @override
  void initState() {
    super.initState();
    entryHandler = EntryHandler(wordGenerator: Words(index: widget.wordIndex));
    gameWord = entryHandler.wordGenerator.allAlphabets();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
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
                  Text(gamePlay.deckEngaged.toString()),
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
                              child: GlowingOverscrollIndicator(
                            color: Colors.limeAccent,
                            axisDirection: AxisDirection.up,
                            child: AnimatedList(
                              key: listKey,
                              physics: BouncingScrollPhysics(),
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
                            ),
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
                      gamePlay.updateLetterState(alphabetDetail, entryHandler);
                    },
                    leftButtonTap: () {
                      setState(() {
                        entryHandler.alphabetHandler.reset();
                        gamePlay.letterMap.reset();
                      });
                    },
                    rightButtonTap: () {},
                  ),
                  AlphabetWidgetDisplay(
                    entryHandler: entryHandler,
                  )
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
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onVerticalDragEnd: (vertical) {
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
                      gamePlay.updateDeck(entryHandler);
                    },
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.bounceInOut,
                  height: gamePlay.deckEngaged ? height * .23 : height * .05,
                  decoration: BoxDecoration(
                    color: gamePlay.deckEngaged
                        ? Colors.green
                        : Colors.black.withOpacity(.4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: width * .08,
                  child: gamePlay.deckEngaged
                      ? Center(
                          child: Text(
                            ' S \n W \n I\n P\n E',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: width * .04),
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
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
