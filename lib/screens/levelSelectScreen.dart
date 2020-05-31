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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    GradientSetter gradientSetter = GradientSetter();
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: gradientSetter.randomPair,
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
                    label: 'SINGLE PLAYER',
                    onPressed: () {
                      Navigator.pushNamed((context), 'SingleLevelOne');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(78.0, 3.0, 78, 3.0),
                  child: LevelCard(
                    label: 'MULTI-PLAYER',
                    onPressed: () {
                      Navigator.pushNamed((context), 'SignInPage');
                    },
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CardButton(
                      height: height,
                      onTap: () {
                        setState(() {
                          gradientSetter = GradientSetter();
                        });
                      },
                    ),
                    CardButton(
                      height: height,
                      onTap: () {
                        setState(() {
                          gradientSetter = GradientSetter();
                        });
                      },
                    )
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
