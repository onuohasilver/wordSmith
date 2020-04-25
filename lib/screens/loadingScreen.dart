import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wordsmith/screens/levelSelectScreen.dart';

import 'dart:async';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // print('tried');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LevelSelectScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  //
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Word',style:TextStyle(color: Colors.white,fontSize: 55)),
            Text('Smith',style:TextStyle(color: Colors.lightBlue,fontSize: 55)),
            SpinKitWave(
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
        ));
  }
}
