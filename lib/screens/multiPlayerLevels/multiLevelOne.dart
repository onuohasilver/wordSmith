import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordsmith/components/cardComponents/cards.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/utilities/alphabetTile.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/core/utilities/dictionaryActivity.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/words.dart';
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

class _MultiLevelOneState extends State<MultiLevelOne> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
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

  int counter = 100;
  Timer timer;
  MappedLetters letterMap;
  void initState() {
    super.initState();
    entryHandler =
        EntryHandler(wordGenerator: Words(index: widget.randomIndex));
    // startTimer();

    letterMap = MappedLetters(alphabets: entryHandler.getWord());
    letterMap.getMapping();
  }

  // void startTimer() {
  //   counter = 10000;

  //   if (timer != null) {
  //     timer.cancel();
  //   }
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (counter > 0) {
  //         counter--;
  //       } else {
  //         timer.cancel();
  //         multiDialogBox(context, entryHandler.scoreKeeper.scoreValue(),
  //             opponentScore, 'MultiLevelTwo');
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> alphabetWidget = [];
    Data userData = Provider.of<Data>(context);
    AppThemeData theme = Provider.of<AppThemeData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              blurBoxLower,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('${userData.userName.toUpperCase()} 😎',
                      style: TextStyle(color: Colors.white)),
                  LittleCard(
                      child: Text(
                          entryHandler.scoreKeeper.scoreValue().toString())),
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
                          score =
                              snapshot.data['activeGames']['currentUserScore'];
                        else {
                          score = '0';
                        }
                        return LittleCard(child: Text(score));
                      }),
                ],
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Colors.white.withOpacity(.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CurrentUserStream(
                                firestore: _firestore,
                                userData: userData,
                                streamEntriesCurrentUser:
                                    streamEntriesCurrentUser,
                                entryHandler: entryHandler)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white.withOpacity(.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            OpponentUserStream(
                                opponentUserID: widget.opponentID,
                                firestore: _firestore,
                                streamEntriesOpponent: streamEntriesOpponent,
                                entryHandler: entryHandler)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //FIXME: Alphabet Widgets do not respond to setState calls. Find a fix.
              // DisplayCurrentEntry(
              //     entryHandler: entryHandler,
              //     letterMap: letterMap,
              //     streamEntriesCurrentUser: streamEntriesCurrentUser,
              //     firestore: _firestore,
              //     userData: userData),
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
                              entryHandler.alphabetHandler.newAlpha.toString(),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
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
                                    activeGamesMap = value['activeGames']);
                            setState(
                              () {
                                String allAlphabets =
                                    entryHandler.alphabetHandler.allAlphabets();

                                entryHandler.alphabetHandler.reset();
                                letterMap.reset();
                                if (!streamEntriesCurrentUser
                                    .contains(allAlphabets)) {
                                  bool criteria = allAlphabets.length > 3;

                                  List currentUserWords = [allAlphabets];
                                  List currentUserValidList = [
                                    verifyWord(entryHandler.getGameWord(),
                                        allAlphabets)
                                  ];
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
                                          'activeGames': activeGamesMap,
                                        }, merge: true)
                                      : print('');

                                  criteria
                                      ? entryHandler.insert(
                                          allAlphabets.trimLeft(),
                                        )
                                      : print('');
                                }
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
    );
  }

  @override
  void dispose() {
    entryHandler = EntryHandler();
    super.dispose();
  }
}
