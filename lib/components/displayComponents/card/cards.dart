import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class LevelCard extends StatelessWidget {
  final String level;
  final bool active;
  final Function onPressed;
  LevelCard({this.level, this.active, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 4.0, 4.0, 0.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: active
              ? Colors.white.withOpacity(0.1)
              : Colors.grey.withOpacity(0.25),
          elevation: 12,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    level,
                    style: TextStyle(
                        fontSize: 20,
                        color: active ? Colors.white : Colors.grey[400]),
                    textAlign: TextAlign.center,
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

class LittleCard extends StatelessWidget {
  LittleCard({@required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.withOpacity(.4),
      child: Padding(padding: const EdgeInsets.all(5.0), child: child),
    );
  }
}


class UserCard extends StatelessWidget {
  const UserCard({Key key, @required this.userName, this.color})
      : super(key: key);

  final String userName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
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
        validator ? Icon(Icons.check,color:Colors.green) : Icon(Icons.cancel,color: Colors.red,)
      ],
    );
  }
}

