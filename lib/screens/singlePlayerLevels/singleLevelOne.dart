import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/singleEntryCard.dart';
import 'package:wordsmith/components/inputComponents/buttons/swipeButton.dart';
import 'package:wordsmith/components/widgetContainers/placeholder.dart';
import 'package:wordsmith/components/widgetContainers/progressBar.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/alphabetWidgetFunction.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/words.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'dart:async';

import 'package:wordsmith/screens/pages/adventureScreen.dart';
import 'package:wordsmith/screens/popUps/dialogs/levelComplete.dart';

class SingleLevelOne extends StatefulWidget {
  const SingleLevelOne({Key key, @required this.wordIndex}) : super(key: key);

  final int wordIndex;

  @override
  _SingleLevelOneState createState() => _SingleLevelOneState();
}

class _SingleLevelOneState extends State<SingleLevelOne>
    with TickerProviderStateMixin {
  final alphabetHandler = Alphabet().createState();
  List<Widget> alphabetWidget = [];
  Animation animation;
  Animation timerAnimation;
  AnimationController animationController;
  AnimationController timerAnimationController;
  EntryHandler entryHandler;
  String gameWord;
  int counter;
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  Timer timer;
  void startTimer() {
    counter = 120;

    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
          showDialog(
            barrierDismissible: false,
              context: context,
              builder: (context) {
                return LevelComplete();
              });
        }
      });
    });
  }

  @override
  void dispose() {
    entryHandler = EntryHandler();
    animationController.dispose();
    timerAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    entryHandler = EntryHandler(wordGenerator: Words(index: widget.wordIndex));
    gameWord = entryHandler.wordGenerator.allAlphabets();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    timerAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 122));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    timerAnimation =
        Tween(begin: 1.0, end: 0.0).animate(timerAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AppThemeData theme = Provider.of<AppThemeData>(context);
    GamePlayData gamePlay = Provider.of<GamePlayData>(context);
    timerAnimationController.forward();
    return Scaffold(
      body: AnimatedBuilder(
          animation: timerAnimationController,
          builder: (context, widget) {
            return Stack(
              children: <Widget>[
                Container(
                  decoration: theme.background,
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        blurBox,
                        SizedBox(height: height * .01),
                        ProgressBar(progress: gamePlay.progress),
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  width: width * .86 * timerAnimation.value,
                                  height: height * .01,
                                  color: Colors.red),
                            ),
                            CircleAvatar(
                              minRadius: width * .015,
                              backgroundColor: Colors.yellow,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                minRadius: width * .013,
                              ),
                            )
                          ],
                        ),
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
                                    initialItemCount:
                                        entryHandler.entryList.length,
                                    itemBuilder: (BuildContext context,
                                        int index, Animation animation) {
                                      List listItems = entryHandler.entryList;
                                      return SizeTransition(
                                        sizeFactor: CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.bounceInOut),
                                        child: ScaleTransition(
                                          scale: CurvedAnimation(
                                              parent: animation,
                                              curve: Interval(0.2, 1.0)),
                                          child: SinglePlayerEntryCard(
                                              key:
                                                  ValueKey(listItems[index][1]),
                                              correct: listItems[index][0],
                                              entry: listItems[index][1]),
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
                            gamePlay.updateLetterState(
                                alphabetDetail, entryHandler);
                          },
                        ),
                        Center(
                          child: AlphabetWidgetDisplay(
                            entryHandler: entryHandler,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, widget) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              height: height * .3 * animation.value,
                              width: width * .3 * animation.value,
                              child: Image.asset('assets/stars.gif'),
                            ),
                            Container(
                              height: height * .3 * animation.value,
                              width: width * .3 * animation.value,
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
                    child: SwipeButton(
                        entryHandler: entryHandler,
                        gamePlay: gamePlay,
                        gameWord: gameWord,
                        listKey: listKey,
                        animationController: animationController,
                        height: height,
                        width: width),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SwipeButton(
                        entryHandler: entryHandler,
                        gamePlay: gamePlay,
                        gameWord: gameWord,
                        listKey: listKey,
                        animationController: animationController,
                        height: height,
                        width: width),
                  ),
                )
              ],
            );
          }),
    );
  }
}
