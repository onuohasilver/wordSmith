import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wordsmith/screens/resultPage.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
import 'package:wordsmith/utilities/alphabets.dart';
import 'dart:collection';
import 'package:wordsmith/utilities/alphabetTile.dart';

class LevelOneEntry extends StatefulWidget {
  @override
  _LevelOneEntryState createState() => _LevelOneEntryState();
}

class _LevelOneEntryState extends State<LevelOneEntry> {
  static EntryHandler entryHandler = EntryHandler();
  final alphabetHandler = Alphabet().createState();

  void initState() {
    super.initState();
    _startTimer();
  }

  int _counter = 300;
  Timer _timer;

  void _startTimer() {
    _counter = 300;

    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  ResultPage(score: entryHandler.scoreKeeper.scoreValue())));
        }
      });
    });
  }

  Map<String, bool> mapWordActive = {
    'f': true,
    'e': true,
    'r': true,
    'n': true
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> alphabetWidget = [];
    for (var alphabet in mapWordActive.keys) {
      alphabetWidget.add(AlphabetButton(
        alphabet: alphabet,
        active: mapWordActive[alphabet],
        onPressed: () {
          setState(() {
            print(mapWordActive.values);
            mapWordActive[alphabet]
                ? entryHandler.alphabetHandler.newAlpha.add(alphabet)
                : print('inactive');
            mapWordActive[alphabet] = false;
          });
        },
      ));
    }
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.2, 1],
                colors: [Colors.lightBlue[900], Colors.lightGreen[700]]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Card(
                        color: Colors.lightBlue.withOpacity(.4),
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_back, color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Card(
                        color: Colors.lightBlue.withOpacity(.4),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              entryHandler.scoreKeeper.scoreValue().toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )),
                    Card(
                      color: Colors.lightBlue.withOpacity(.4),
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                (_counter > 0)
                                    ? Text(
                                        '00:$_counter',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      )
                                    : Text("Game Over",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20)),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: ListView(
                                reverse: false,
                                shrinkWrap: true,
                                children: UnmodifiableListView(
                                    entryHandler.entryList)))
                      ],
                    ),
                  ),
                ),
                Card(
                    color: Colors.lightBlue.withOpacity(.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                                entryHandler.alphabetHandler.newAlpha
                                    .toString(),
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
                              setState(() {
                                mapWordActive = {
                                  'f': true,
                                  'e': true,
                                  'r': true,
                                  'n': true
                                };
                                entryHandler.insert(entryHandler.alphabetHandler
                                    .allAlphabets()
                                    .trimLeft());
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Wrap(
                  direction: Axis.horizontal,
                  children: alphabetWidget,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LetterActivePair {
  String word;
  bool active;
  LetterActivePair(this.word, this.active);
}
