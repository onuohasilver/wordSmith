import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class LevelCard extends StatelessWidget {
  final String label;

  final Function onPressed;

  /// Returns a flat Tap-aware Card Widget
  LevelCard({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 10.0, 0.0),
      child: Material(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white.withOpacity(0.2),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: onPressed,
          )),
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.title,
      @required this.content})
      : super(key: key);

  final double height;
  final double width;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * .1,
        width: width * .4,
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
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
          color: Colors.white.withOpacity(.2),
        ),
      ),
    );
  }
}

/// Returns a tap-aware material rounded button
class CardButton extends StatelessWidget {
  const CardButton({
    Key key,
    @required this.icon,
    @required this.height,
    @required this.onTap,
  }) : super(key: key);

  final double height;
  final Function onTap;
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
  LittleCard({@required this.child});
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
  const UserCard({Key key, @required this.userName, this.color, @required this.onTap})
      : super(key: key);

  final String userName;
  final Color color;
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
          color: color.withOpacity(.4),
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
