import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' show pi;
import 'package:wordsmith/utilities/entryHandler.dart';

class LevelCard extends StatelessWidget {
  ///Text displayed on Card Body [label] must be a non-null value
  final String label;

  ///Named route to be navigated to onTap [routeName] must not be a non-null value
  final String routeName;

  ///MediaQuery height data[height] must be specified.
  final double height;

  ///MediaQuery height data[width] must be specified.
  final double width;

  /// a controller that needs to be disposed on page routing
  final AnimationController controller;

  /// Returns a flat Tap-aware Card Widget with [assets/labelHanger.png] as a background
  ///  that takes two
  /// arguments the card [label] that will be displayed on the
  /// card body and the [routeName] which is a specified route
  /// where the card navigates to onTap both values are String values.

  /// ```dart
  /// LevelCard('Card Label','Home Screen');
  /// ```
  LevelCard({
    this.label,
    @required this.routeName,
    @required this.height,
    @required this.width,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(80.0, 13.0, 88.0, 3.0),
      child: Stack(
        children: [
          Container(child: Image.asset('assets/labelHanger.png')),
          Positioned.fill(
            bottom: height * .01,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: -pi / 33,
                child: Container(
                  height: height * .09,
                  width: width * .58,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      splashColor: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            label,
                            style: GoogleFonts.creepster(
                                fontSize: height * .03, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed((context), routeName);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      this.iconPath})
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          height: height * .15,
          width: width * .3,
          child: Image.asset(
            'assets/labelHanger2.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          top:height*0.04,
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
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform.rotate(
              angle: pi / 33,
              child: Container(
                height: height * .1,
                width: width * .4,
                child: Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(500),
                      splashColor: Colors.lightGreen[600].withOpacity(.5),
                      onTap: () {},
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

class CardButton extends StatelessWidget {
  /// Returns a tap-aware material rounded button
  /// that displays an Icon on a faded white background
  /// [icon] IconData is centered and with a default color of white.
  ///
  /// Sizing of the CardButton is achieved using a ratio of the MediaQuery height
  /// provided as the [height] argument. with the CardButton Occupying 5% of the device height
  /// ```dart
  /// CardButton(height:height,
  ///           onTap:()=>DoSomething(),
  ///           icon:Icons.forward)
  /// ```
  const CardButton({
    Key key,
    @required this.icon,
    @required this.height,
    @required this.onTap,
  }) : super(key: key);

  ///MediaQuery height
  final double height;

  ///Function to be executed on button tap
  final Function onTap;

  ///Icon to be displayed on the card body
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white.withOpacity(.2),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.white, size: height * .05),
            ),
            splashColor: Colors.white,
            onTap: onTap));
  }
}

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

class EntryCard extends StatelessWidget {
  EntryCard({this.entry, this.handler});
  final String entry;
  final EntryHandler handler;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        elevation: 24,
        color: Colors.primaries[entry.length + 3 % Colors.primaries.length]
            .withOpacity(.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                entry.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class RowEntryCard extends StatelessWidget {
  RowEntryCard({this.entryCard, this.validator});
  final EntryCard entryCard;
  final bool validator;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        entryCard,
        validator
            ? Icon(Icons.check, color: Colors.green)
            : Icon(
                Icons.cancel,
                color: Colors.red,
              )
      ],
    );
  }
}
