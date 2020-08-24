import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  Stack(
                    children: <Widget>[
                      ProgressBar(
                          height: height,
                          width: width,
                          color: Colors.blue,
                          progress: gamePlay.progress),
                      Row(
                        children: <Widget>[
                          Text('${widget.opponentName.toUpperCase()} ',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
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
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.blue.withOpacity(.2),
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
                              height: height,
                              width: width,
                              progress: gamePlay.progress),
                          Row(
                            children: <Widget>[
                              Text('${userData.userName.toUpperCase()} ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              LittleCard(
                                color:Colors.green,
                                  child: Text(
                                      entryHandler.scoreKeeper
                                          .scoreValue()
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))),
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
                  allowUpload: true,
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
                  allowUpload: true,
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
