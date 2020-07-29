import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/components/displayComponents/card/entryCard.dart';
import 'dart:math' show pi;
import 'package:wordsmith/utilities/entryHandler.dart';

class LittleCard extends StatelessWidget {
  ///A widget that wraps its child in a background with white opacity and a padding of 5px
  ///The LittleCard despite its name can expand to the size of its child.
  ///```dart
  ///LittleCard(child:Text('ScareCrow'));
  ///````
  LittleCard({@required this.child});

  ///Widget displayed in the body of the LittleCard
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(.4),
      child: Padding(padding: const EdgeInsets.all(5.0), child: child),
    );
  }
}

class UserCard extends StatelessWidget {
  ///Creates a Card that displays a user's name and also accept touch gestures
  ///color defaults to White with an opacity of .4
  ///```dart
  ///UserCard(userName:'')
  const UserCard(
      {Key key, @required this.userName, this.color, @required this.onTap})
      : super(key: key);

  ///Name[String] of the User as displayed on the firebase db
  final String userName;

  ///Color[Color] of the Card
  final Color color;

  ///onTap [Function]  function to be executed on gesture detection.
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.only(left: 9, right: 9, top: 5),
          elevation: 6,
          color: color.withOpacity(.4) ?? Colors.white.withOpacity(.4),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$userName '.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

