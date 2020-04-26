import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
import 'dart:collection';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';

class LevelOneEntry extends StatefulWidget {
  @override
  _LevelOneEntryState createState() => _LevelOneEntryState();
}

class _LevelOneEntryState extends State<LevelOneEntry> {
  EntryHandler entryHandler = EntryHandler();
  final nameHolder = TextEditingController();
  ScrollController scrollController = ScrollController();
  void initState() {
    super.initState();
    _startTimer();
  }

  int _counter = 60;
  Timer _timer;

  void _startTimer() {
    _counter = 60;

    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
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
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/levelSelect.jpg'), fit: BoxFit.cover),
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
                        color: Colors.red,
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_back, color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                (_counter > 0)
                                    ? Text(
                                        '$_counter',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )
                                    : Text("Game Over",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
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
                    color: Colors.white.withOpacity(.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: TextLiquidFill(
                            loadDuration: Duration(seconds:60),
                            waveDuration: Duration(seconds:5),
                            text: 'FERMENTATION',
                            waveColor: Colors.blueAccent,
                            boxBackgroundColor: Colors.black,
                            textStyle: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                            boxHeight: 60.0,
                            boxWidth: 250.0,
                          ),
                        ),
                        Expanded(
                            child: ListView(
                                controller: scrollController,
                                reverse: false,
                                shrinkWrap: true,
                                children: UnmodifiableListView(
                                    entryHandler.entryList)))
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: nameHolder,
                        autocorrect: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Enter Word',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          entryHandler.entry = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            entryHandler.entry = entryHandler.entry;
                          });

                          entryHandler.insert();
                          nameHolder.clear();
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

Widget buildItem(String item, Animation animation) {
  return SizeTransition(
    sizeFactor: animation,
    child: Align(
      alignment: Alignment.center,
      child: Card(
          color: Colors.black,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 15),
              Icon(Icons.check_box, color: Colors.green)
            ],
          )),
    ),
  );
}
