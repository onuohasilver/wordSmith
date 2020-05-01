import 'package:flutter/material.dart';
import 'package:wordsmith/screens/levels/level_one_entry.dart';
import 'package:wordsmith/utilities/components.dart';

class LevelSelectScreen extends StatefulWidget {
  @override
  _LevelSelectScreenState createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'WORD SMITH',
                  textAlign:TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.w700,fontSize:35),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(78.0,3.0,78,3.0),
                  child: LevelCard(
                    active: true,
                    level: 'PLAY',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LevelOneEntry();
                      }));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
