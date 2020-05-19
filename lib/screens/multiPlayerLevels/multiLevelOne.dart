import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final String currentUserName;
  final String currentUserID;
  final String opponentGameID;
  final String currentUserGameID;
  final int randomIndex;

  MultiLevelOne({
    this.randomIndex,
    this.opponentName,
    this.currentUserGameID,
    this.opponentGameID,
    this.opponentID,
    this.currentUserName,
    this.currentUserID,
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

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  int counter = 100;
  Timer timer;

  void initState() {
    super.initState();
    entryHandler =
        EntryHandler(wordGenerator: Words(index: widget.randomIndex));
    startTimer();
    getCurrentUser();

    letterMap = MappedLetters(alphabets: entryHandler.getWord());
    letterMap.getMapping();
  }

  void startTimer() {
    counter = 100;

    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
          multiDialogBox(context, entryHandler.scoreKeeper.scoreValue(),opponentScore,
              'MultiLevelTwo');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> alphabetWidget = [];

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
          decoration: kGreenPageDecoration,
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
                        Navigator.popAndPushNamed(context, 'ChooseOpponent');
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
                    Text('${widget.currentUserName.toUpperCase()} 😎',
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
                              StreamBuilder<DocumentSnapshot>(
                                  stream: _firestore
                                      .collection('entry')
                                      .document(widget.currentUserGameID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<Widget> entryWidgets = [];
                                    if (snapshot.hasData) {
                                      final entry = snapshot.data;
                                      final entryValue = entry.data['text'];
                                      final senderID = entry.data['senderID'];
                                      final gameID = entry.data['gameID'];
                                      final validator = entry.data['validate'];
                                      final score = entry.data['score'];
                                      EntryCard entryWidget;
                                      if ((widget.currentUserID == senderID) &
                                          (widget.currentUserGameID ==
                                              gameID)) {
                                        for (int index = 0;
                                            index < entryValue.length;
                                            index++) {
                                          currentUserScore = score;
                                          streamEntriesCurrentUser
                                              .add(entryValue[index]);
                                          entryList =
                                              streamEntriesCurrentUser.toList();
                                          entryWidget = EntryCard(
                                              entry: entryValue[index],
                                              handler: entryHandler);
                                          final rowEntryWidget = RowEntryCard(
                                              entryCard: entryWidget,
                                              validator: validator[index]);
                                          entryWidgets.add(rowEntryWidget);
                                        }
                                      }
                                    }
                                    return Expanded(
                                        child:
                                            ListView(children: entryWidgets));
                                  })
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
                              StreamBuilder<DocumentSnapshot>(
                                  stream: _firestore
                                      .collection('entry')
                                      .document(widget.opponentGameID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    List<Widget> entryWidgets = [];
                                    if (!snapshot.hasData) {
                                       return Container() ;
                                    }else{
                                      final entry = snapshot.data;
                                      final entryValue = entry.data['text'];
                                      final senderID = entry.data['senderID'];
                                      final gameID = entry.data['gameID'];
                                      final validator = entry.data['validate'];
                                      final String score = entry.data['score'];
                                      EntryCard entryWidget;
                                      if ((widget.opponentID == senderID) &
                                          (widget.opponentGameID == gameID)) {
                                        for (int index = 0;
                                            index < entryValue.length;
                                            index++) {
                                          streamEntriesOpponent
                                              .add(entryValue[index]);
                                          opponentScore = int.parse(score);
                                          entryWidget = EntryCard(
                                              entry: entryValue[index],
                                              handler: entryHandler);
                                          final rowEntryWidget = RowEntryCard(
                                              entryCard: entryWidget,
                                              validator: validator[index]);
                                          entryWidgets.add(rowEntryWidget);
                                        }
                                      }
                                    }
                                    return Expanded(
                                        child:
                                            ListView(children: entryWidgets));
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
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
                                  if (!streamEntriesCurrentUser
                                      .contains(allAlphabets)) {
                                    bool criteria = allAlphabets.length > 3;

                                    entryList.add(allAlphabets);
                                    validateList.add(verifyWord(
                                        entryHandler.getGameWord(),
                                        allAlphabets));

                                    criteria
                                        ? _firestore
                                            .collection('entry')
                                            .document(widget.currentUserGameID)
                                            .setData({
                                            'senderID': widget.currentUserID,
                                            'text': entryList,
                                            'gameID': widget.currentUserGameID,
                                            'validate': validateList,
                                            'score': entryHandler.scoreKeeper
                                                .scoreValue()
                                                .toString()
                                          }, merge: true)
                                        : print('');

                                    criteria
                                        ? entryHandler.insert(
                                            allAlphabets.trimLeft(),
                                          )
                                        : print('');
                                  }
                                  entryHandler.alphabetHandler.reset();
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
