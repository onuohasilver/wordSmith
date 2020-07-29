import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/displayComponents/card/displayCurrent.dart';
import 'package:wordsmith/components/streamLogic/currentUserStream.dart';
import 'package:wordsmith/components/streamLogic/opponentUserStream.dart';
import 'package:wordsmith/userProvider/themeData.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
import 'package:wordsmith/components/displayComponents/buttons/alphabets.dart';
import 'package:wordsmith/utilities/alphabetTile.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/components/displayComponents/popUps/dialogBox.dart';
import 'package:wordsmith/utilities/dictionaryActivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordsmith/utilities/words.dart';

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
  MappedLetters letterMap;
  FirebaseUser loggedInUser;

  int counter = 100;
  Timer timer;

  void initState() {
    super.initState();
    entryHandler =
        EntryHandler(wordGenerator: Words(index: widget.randomIndex));
    startTimer();

    letterMap = MappedLetters(alphabets: entryHandler.getWord());
    letterMap.getMapping();
  }

  void startTimer() {
    counter = 10000;

    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
          multiDialogBox(context, entryHandler.scoreKeeper.scoreValue(),
              opponentScore, 'MultiLevelTwo');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> alphabetWidget = [];
    Data userData = Provider.of<Data>(context);
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: theme.background,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                blurBoxLower,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: LittleCard(
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                      onTap: () {
                        Navigator.popAndPushNamed(context, 'FriendsScreen');
                      },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('${userData.userName.toUpperCase()} 😎',
                        style: TextStyle(color: Colors.white)),
                    LittleCard(child: Text(currentUserScore)),
                    Text('${widget.opponentName.toUpperCase()} 😎',
                        style: TextStyle(color: Colors.white)),
                    LittleCard(child: Text(opponentScore.toString())),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: Colors.white.withOpacity(.3),
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
                          color: Colors.white.withOpacity(.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              OpponentUserStream(
                                  firestore: _firestore,
                                  widget: widget,
                                  streamEntriesOpponent: streamEntriesOpponent,
                                  entryHandler: entryHandler)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DisplayCurrentEntry(
                    entryHandler: entryHandler,
                    letterMap: letterMap,
                    streamEntriesCurrentUser: streamEntriesCurrentUser,
                    firestore: _firestore,
                    userData: userData),
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
