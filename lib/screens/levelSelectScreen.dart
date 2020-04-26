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
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/levelSelect.jpg'), fit: BoxFit.cover),
          ),
          child: GridView.count(
            crossAxisCount: 3,
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
