import 'dart:math';

import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  ///Creates a Card to display the Score of a Player
  ///[content] argument must be non-null
  ///[title] argument must be non-null
  ///```dart
  ///ScoreCard(height:height,width:width,title:'Card Title',content:'Card Content');
  ///```
  ///[height] and [width] args are size references gotten from MediaQuery size requests.
  const ScoreCard(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.title,
      @required this.content,
      this.iconPath,
      this.toolTip,
      this.routeName})
      : super(key: key);

  ///MediaQuery height value: must be a double
  final double height;

  ///MediaQuery width value: must be a double
  final double width;

  ///Title of the Card defaults to null and must be provided
  final String title;

  ///Content of the Card defaults to null and must be provided
  final String content;

  ///Path [String] of the icon
  final String iconPath;

  ///tooltip message to be displayed [String]
  final String toolTip;

  /// route to be navigated to on button press [String]
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          height: height * .15,
          width: width * .3,
          child: Material(
            color: Colors.transparent,
            elevation: 50,
            child: Image.asset(
              'assets/labelHanger2.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned.fill(
          top: height * 0.04,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: height * .07,
              width: width * .15,
              child: Material(
                elevation: 60,
                color: Colors.transparent,
                child: Image.asset(
                  iconPath ?? 'assets/ff.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: height * .01,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform.rotate(
              angle: pi / 33,
              child: Container(
                height: height * .09,
                width: width * .4,
                child: Material(
                    child: Tooltip(
                      message: toolTip,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(500),
                        splashColor: Colors.lightGreen[600].withOpacity(.5),
                        onTap: () => Navigator.pushNamed(context, routeName),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                  color: Colors.lightGreen[600].withOpacity(.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            content,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          )
                        ]),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
