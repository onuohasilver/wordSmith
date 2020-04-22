import 'package:flutter/material.dart';
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
        child: ListView(
          children: <Widget>[
            LevelCard(level: 'Level 1',active:true),
            LevelCard(level: 'Level 2',active:false),
            LevelCard(level: 'Level 3',active:false),
            LevelCard(level: 'Level 4',active:false),
            LevelCard(level: 'Level 5',active:false),
            LevelCard(level: 'Level 6',active:false),
            LevelCard(level: 'Level 7',active:false),
            LevelCard(level: 'Level 8',active:false),
            LevelCard(level: 'Level 9',active:false),
            LevelCard(level: 'Level 10',active:false),
            LevelCard(level: 'Level 11',active:false),
            LevelCard(level: 'Level 12',active:false)
          ],
        ),
      ),),
    );
  }
}

