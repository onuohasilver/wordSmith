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

dialogBox(context, String score, String level) {
  showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
        backgroundColor: Colors.blue.withOpacity(.4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LittleCard(
                child: Text(
              'SCORE: $score',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            )),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                onTap: () { 
                   
                   Navigator.pop(context);
                   Navigator.pop(context);
                   Navigator.pushReplacementNamed(context,level);
                },
                child: LittleCard(
                  child: Icon(
                    Icons.forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              LittleCard(
                child: Icon(Icons.backspace, color: Colors.white, size: 40),
              ),
            ])
          ],
        ),
      ));
}




class SlimButton extends StatelessWidget {
  SlimButton({this.onTap, this.label,this.color,this.textColor});
  final String label;
  final Function onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(34, 10, 34, 10),
            child: Text(
              label,
              style:
                  TextStyle(color: this.textColor, fontWeight: FontWeight.w600),
            ),
          ),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color:color),
    );
  }
}

class EntryCard extends StatelessWidget {
  EntryCard({this.entry,this.handler});
  final String entry;
  final EntryHandler handler;
  @override
  Widget build(BuildContext context) {
    bool correct = handler.validate(entry: entry,returnScore: false);
    return Align(
        child: Card(  
          elevation: 24,
          color: Colors.primaries[entry.length + 3 % Colors.primaries.length]
              .withOpacity(0.4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // SizedBox(width: 15),
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
              Icon(correct ? Icons.check_box : Icons.cancel,
                  color: correct ? Colors.green : Colors.red),
              // SizedBox(width: 15),
            ],
          ),
        ),
      );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.userName,
    this.color
  }) : super(key: key);

  final String userName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
          left: 9, right: 9, top: 5),
      elevation: 6,
      color: color.withOpacity(.4),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$userName '.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
