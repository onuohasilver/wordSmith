import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
import 'package:wordsmith/utilities/alphabets.dart';
import 'package:wordsmith/utilities/alphabetTile.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:wordsmith/utilities/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MultiLevelOne extends StatefulWidget {
  final String opponentName;
  final String opponentID;
  final String currentUserName;
  final String currentUserID;
  MultiLevelOne(
      {this.opponentName,
      this.opponentID,
      this.currentUserName,
      this.currentUserID});
  @override
  _MultiLevelOneState createState() => _MultiLevelOneState();
}

class _MultiLevelOneState extends State<MultiLevelOne> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  static EntryHandler entryHandler = EntryHandler();
  final Set<String> streamEntries = Set();
  final alphabetHandler = Alphabet().createState();
  final MappedLetters letterMap =
      MappedLetters(alphabets: entryHandler.getWord());
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

  int counter = 1000;
  Timer timer;

  void initState() {
    super.initState();
    startTimer();
    getCurrentUser();
    letterMap.getMapping();
  }

  void startTimer() {
    counter = 1000;

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
          decoration: kLevelOneContainerDecoration,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(widget.currentUserName.toUpperCase(),
                        style: TextStyle(color: Colors.white)),
                    Text(widget.opponentName.toUpperCase(),
                        style: TextStyle(color: Colors.white))
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
                              StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection('entry')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final entries = snapshot.data.documents;
                                      List<Widget> entryWidgets = [];
                                      for (var entry in entries) {
                                        final entryValue = entry.data['text'];
                                        final senderID = entry.data['senderID'];
                                        EntryCard entryWidget;

                                        if ((widget.currentUserID ==
                                            senderID)) {
                                          streamEntries.add(entryValue);

                                          entryWidget = EntryCard(
                                              entry: entryValue,
                                              handler: entryHandler);
                                          entryWidgets.add(entryWidget);
                                        }
                                      }
                                      return Expanded(
                                          child:
                                              ListView(children: entryWidgets));
                                    }
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
                              StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection('entry')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final entries = snapshot.data.documents;
                                      List<Widget> entryWidgets = [];
                                      for (var entry in entries) {
                                        final entryValue = entry.data['text'];
                                        final senderID = entry.data['senderID'];

                                        if ((widget.opponentID == senderID)) {
                                          streamEntries.add(entryValue);
                                          if (streamEntries
                                              .contains(entryValue)) {
                                            final entryWidget = EntryCard(
                                                entry: entryValue,
                                                handler: entryHandler);
                                            entryWidgets.add(entryWidget);
                                          }
                                        }
                                      }
                                      return Expanded(
                                          child:
                                              ListView(children: entryWidgets));
                                    }
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
                                  bool criteria = allAlphabets.length > 3;
                                  entryHandler.alphabetHandler.reset();
                                  _firestore.collection('entry').add({
                                    'senderID': widget.currentUserID,
                                    'text': allAlphabets,
                                  });

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
