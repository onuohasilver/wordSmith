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
          color: active ? Colors.black.withOpacity(0.25) :Colors.grey.withOpacity(0.25),
          elevation: 12,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Text(
                  level,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: active ? Colors.white : Colors.grey[400]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height:4),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: active?Colors.yellow:Colors.grey[400]),
                    Icon(Icons.star, color: active?Colors.yellow:Colors.grey[400]),
                    Icon(Icons.star_half, color: active?Colors.yellow:Colors.grey[400])
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



