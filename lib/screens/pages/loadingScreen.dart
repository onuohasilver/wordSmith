import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/core/utilities/words.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/sqlCache.dart';

import 'dart:async';

import 'package:wordsmith/screens/pages/levelSelectScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SelectScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    EntryHandler(wordGenerator: Words(index: 2)).insert('    ');
    startTime();
  }

  //
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('WORD',
                  style: TextStyle(color: Colors.white, fontSize: 55),
                  textAlign: TextAlign.center),
              Text('SMITH',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 55),
                  textAlign: TextAlign.center),
              SpinKitChasingDots(
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.white : Colors.white,
                    ),
                  );
                },
                size: 45,
                duration: Duration(milliseconds: 4000),
              ),
            ],
          ),
        ));
  }
}
