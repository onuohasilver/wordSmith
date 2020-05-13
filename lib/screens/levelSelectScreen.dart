import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';

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
          decoration: kLevelSelectContainerDecoration,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('WORD SMITH',
                    textAlign: TextAlign.center, style: kTitleSelectText),
                Padding(
                  padding: const EdgeInsets.fromLTRB(78.0, 3.0, 78, 3.0),
                  child: LevelCard(
                    active: true,
                    level: 'SINGLE PLAYER',
                    onPressed: () {
                      Navigator.pushNamed((context), 'SingleLevelOne');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(78.0, 3.0, 78, 3.0),
                  child: LevelCard(
                    active: true,
                    level: 'MULTI-PLAYER',
                    onPressed: () {
                      Navigator.pushNamed((context), 'SignInPage');
                    },
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
