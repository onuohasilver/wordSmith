import 'package:flutter/material.dart';

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
