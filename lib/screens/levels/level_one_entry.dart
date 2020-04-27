import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wordsmith/screens/resultPage.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
import 'package:wordsmith/utilities/alphabets.dart';
import 'dart:collection';

class LevelOneEntry extends StatefulWidget {
  @override
  _LevelOneEntryState createState() => _LevelOneEntryState();
}

class _LevelOneEntryState extends State<LevelOneEntry> {
  EntryHandler entryHandler = EntryHandler();
  final alphabetHandler = Alphabet().createState();

  void initState() {
    super.initState();
    _startTimer();
  }

  int _counter = 200;
  Timer _timer;

  void _startTimer() {
    _counter = 200;

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

  @override
  Widget build(BuildContext context) {
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
                Wrap(direction: Axis.horizontal, children: <Widget>[
                  AlphabetButton(alphabet: 'F', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'E', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'R', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'M', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'E', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'N', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'T', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'E', entryHandler: entryHandler),
                  AlphabetButton(alphabet: 'D', entryHandler: entryHandler),
                ]),
                Row(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            entryHandler.insert(entryHandler.alphabetHandler
                                .allAlphabets()
                                .trimLeft());
                            print(entryHandler.alphabetHandler
                                .allAlphabets()
                                .trimLeft()
                                .length);
                          });
                        },
                        child: Icon(Icons.control_point,
                            color: Colors.lightBlue, size: 50.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlphabetButton extends StatelessWidget {
  AlphabetButton({@required this.entryHandler, @required this.alphabet});

  final EntryHandler entryHandler;
  final String alphabet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        entryHandler.alphabetHandler.newAlpha.add(alphabet);
      },
      child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(alphabet,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ),
          color: Colors.white.withOpacity(.4)),
    );
  }
}
