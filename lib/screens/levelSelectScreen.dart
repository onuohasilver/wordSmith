import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/components.dart';
import 'package:wordsmith/screens/levels/level_one.dart';
import 'package:wordsmith/utilities/dictionaryACtivity.dart';

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
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/levelSelect.jpg'), fit: BoxFit.cover),
          ),
          child: ListView(
            children: <Widget>[
              LevelCard(
                  level: 'Level 1',
                  active: true,
                  onPressed: () {
                    // getPermutations('Great');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LevelOne();
                        },
                      ),
                    );
                  }),
              LevelCard(level: 'Level 2', active: false),
              LevelCard(level: 'Level 3', active: false),
              LevelCard(level: 'Level 4', active: false),
              LevelCard(level: 'Level 5', active: false),
              LevelCard(level: 'Level 6', active: false),
              LevelCard(level: 'Level 7', active: false),
              LevelCard(level: 'Level 8', active: false),
              LevelCard(level: 'Level 9', active: false),
              LevelCard(level: 'Level 10', active: false),
              LevelCard(level: 'Level 11', active: false),
              LevelCard(level: 'Level 12', active: false)
            ],
          ),
        ),
      ),
    );
  }
}
