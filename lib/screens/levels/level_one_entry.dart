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
  AlphabetWidgets alphabetWidgets = AlphabetWidgets();

  void initState() {
    super.initState();
    _startTimer();
    alphabetWidgets.getWidgets(['a','b','f','e','r','r'],(){print('a');},entryHandler);
    print(alphabetWidgets.alphabetWidgets);
  }

  int _counter = 20;
  Timer _timer;

  void _startTimer() {
    _counter = 20;

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
                Card(
                    color: Colors.lightBlue.withOpacity(.4),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                            entryHandler.alphabetHandler.newAlpha.toString(),
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    )),
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
                Wrap(direction: Axis.horizontal, children: alphabetWidgets.alphabetWidgets),
                Row(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            entryHandler.insert(entryHandler.alphabetHandler
                                .allAlphabets()
                                .trimLeft());
                            alphabetWidgets.activeAlphabets.fillRange(0, alphabetWidgets.activeAlphabets.length,false) ;
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







class AlphabetWidgets {
  
  List<Widget> alphabetWidgets=[];
  List<bool> activeAlphabets=[];
  int index = 0;
  String currentAlphabet;

  getWidgets(List alphabets,Function onPressed,entryHandler) {
    
    alphabets.forEach((alphabet) {
      currentAlphabet=alphabet;
      activeAlphabets.add(true);
      alphabetWidgets.add(
        AlphabetButton(
          alphabet: alphabet,
          active: activeAlphabets[index],
          onPressed: onPressed,
        ),
      );
      index++;
    });
  }
}
