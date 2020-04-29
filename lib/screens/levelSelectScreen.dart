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
            gradient:LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops:[0.2,1],
            colors: [Colors.lightBlue[900],Colors.lightGreen[700]]
          ),),
          child: GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              LevelCard(
                  level: 'Level 1',
                  active: true,
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LevelOneEntry();
                        },
                      ),
                    );
                  }),
              LevelCard(level: 'Level 2', active: false),
              LevelCard(level: 'Level 2', active: false),
              LevelCard(level: 'Level 2', active: false),
              LevelCard(level: 'Level 2', active: false),
              LevelCard(level: 'Level 2', active: false),
              LevelCard(level: 'Level 2', active: false)
            ],
          ),
        ),
      ),
    );
  }
}
