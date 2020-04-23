import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final String level;
  final bool active;
  final Function onPressed;
  LevelCard({this.level, this.active,this.onPressed});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 4.0, 4.0, 0.0),
      child: GestureDetector(
              onTap: onPressed,
              child: Card(
          color: active ? Colors.black : Colors.grey,
          elevation: 12,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 22),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    level,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: active ? Colors.white : Colors.grey[400]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.vpn_key,
                        color: active ? Colors.lightBlue : Colors.grey[400]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
