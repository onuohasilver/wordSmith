import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordsmith/components/cardComponents/cards.dart';
import 'package:wordsmith/components/inputComponents/buttons/swipeButton.dart';
import 'package:wordsmith/components/widgetContainers/placeholder.dart';
import 'package:wordsmith/core/alphabetWidgetFunction.dart';
import 'package:wordsmith/components/widgetContainers/progressBar.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/utilities/alphabetTile.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/words.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:wordsmith/handlers/stateHandlers/streamLogic/currentUserStream.dart';
import 'package:wordsmith/handlers/stateHandlers/streamLogic/opponentUserStream.dart';

class MultiLevelOne extends StatefulWidget {
  final String opponentName;
  final String opponentID;
  final int randomIndex;

  MultiLevelOne({
    this.randomIndex,
    this.opponentName,
    this.opponentID,
  });
  @override
  _MultiLevelOneState createState() => _MultiLevelOneState();
}

class _MultiLevelOneState extends State<MultiLevelOne>
    with SingleTickerProviderStateMixin {
  final _firestore = Firestore.instance;

  final Set<String> streamEntriesCurrentUser = Set();
  final Set<String> streamEntriesOpponent = Set();
  int opponentScore = 0;
  String currentUserScore = '0';
  final alphabetHandler = Alphabet().createState();
  List<String> entryList = [];
  List<bool> validateList = [];
  EntryHandler entryHandler;
  Firestore firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  String gameWord;
  double progress = 0;
  Animation animation;
  AnimationController animationController;

  int counter = 100;
  Timer timer;
  MappedLetters letterMap;
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  void initState() {
    super.initState();
    entryHandler =
        EntryHandler(wordGenerator: Words(index: widget.randomIndex));
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);

    gameWord = entryHandler.wordGenerator.allAlphabets();
  }

  @override
  Widget build(BuildContext context) {
    Data userData = Provider.of<Data>(context);
    AppThemeData theme = Provider.of<AppThemeData>(context);
    GamePlayData gamePlay = Provider.of<GamePlayData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  blurBoxLower,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('${widget.opponentName.toUpperCase()} 😎',
                          style: TextStyle(color: Colors.white)),
                      StreamBuilder<DocumentSnapshot>(
                          stream: firestore
                              .collection('users')
                              .document(widget.opponentID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            String score;
                            if (snapshot.hasData)
                              score = snapshot.data['activeGames']
                                  ['currentUserScore'];
                            else {
                              score = '0';
                            }
                            return LittleCard(child: Text(score));
                          }),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.red.withOpacity(.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                OpponentUserStream(
                                    opponentUserID: widget.opponentID,
                                    firestore: _firestore,
                                    streamEntriesOpponent:
                                        streamEntriesOpponent,
                                    entryHandler: entryHandler)
                              ],
                            ),
                          ),
                        ),
                        Stack(children: [
                          ProgressBar(
                              height: height, width: width, progress: progress),
                          Row(
                            children: <Widget>[
                              Text('${userData.userName.toUpperCase()} 😎',
                                  style: TextStyle(color: Colors.white)),
                              LittleCard(
                                  child: Text(entryHandler.scoreKeeper
                                      .scoreValue()
                                      .toString())),
                            ],
                          ),
                        ]),
                        Expanded(
                          child: Card(
                            color: Colors.green.withOpacity(.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CurrentUserStream(
                                    firestore: _firestore,
                                    userData: userData,
                                    listKey: listKey,
                                    streamEntriesCurrentUser:
                                        streamEntriesCurrentUser,
                                    entryHandler: entryHandler)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                      color: Colors.lightGreen.withOpacity(.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.delete_forever,
                                  color: Colors.red, size: width * .07),
                              onPressed: () {
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
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              icon: Icon(Icons.send,
                                  color: Colors.green, size: width * .07),
                              onPressed: () async {
                                ///retrieve all the previously entered words from firestore
                                /// so that it can be merged with the current entry and re-uploaded
                                Map activeGamesMap;
                                await _firestore
                                    .collection('users')
                                    .document(userData.currentUserID)
                                    .get()
                                    .then((value) =>
                                        activeGamesMap = value['activeGames ']);
                                print(activeGamesMap);
                                String allAlphabets =
                                    entryHandler.alphabetHandler.allAlphabets();
                                entryHandler.alphabetHandler.reset();
                                gamePlay.letterMap.reset();
                                verifyWord(gameWord, allAlphabets)
                                    ? gamePlay.updateProgress()
                                    : gamePlay.updateProgress(increment: 0);
                                bool criteria = allAlphabets.length >= 3;

                                criteria
                                    ? entryHandler
                                        .insert(allAlphabets.trimLeft())
                                    : Container();
                                criteria
                                    ? listKey.currentState.insertItem(0,
                                        duration: Duration(seconds: 2))
                                    : Container();
                                gamePlay.straightWins(entryHandler);
                                gamePlay.straightThree
                                    ? animationController.repeat()
                                    : animationController.reset();
                                gamePlay.updateDeck(entryHandler);
                                if (!streamEntriesCurrentUser
                                    .contains(allAlphabets)) {
                                  bool criteria = allAlphabets.length > 3;

                                  List currentUserWords = [allAlphabets];
                                  List currentUserValidList = [
                                    verifyWord(entryHandler.getGameWord(),
                                        allAlphabets)
                                  ];
                                  print(activeGamesMap['currentUserWords']);
                                  currentUserWords.addAll(
                                      activeGamesMap['currentUserWords']);
                                  currentUserValidList.addAll(
                                      activeGamesMap['currentUserValidList']);
                                  activeGamesMap['currentUserWords'] =
                                      currentUserWords;
                                  activeGamesMap['currentUserScore'] =
                                      entryHandler.scoreKeeper
                                          .scoreValue()
                                          .toString();
                                  activeGamesMap['currentUserValidList'] =
                                      currentUserValidList;

                                  criteria
                                      ? _firestore
                                          .collection('users')
                                          .document(userData.currentUserID)
                                          .setData({
                                          'activeGames ': activeGamesMap,
                                        }, merge: true)
                                      : print('');
                                }
                              },
                            ),
                          ),
                        ],
                      )),
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
                  ),
                  AlphabetWidgetDisplay(
                    entryHandler: entryHandler,
                  )
                ],
              ),
            ),
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
      ),
    );
  }

  @override
  void dispose() {
    entryHandler = EntryHandler();
    super.dispose();
  }
}
