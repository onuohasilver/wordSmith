import 'package:flutter/material.dart';

class Alphabet extends StatefulWidget {
  @override
  _AlphabetState createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
  List<String> newAlpha =[];
  String entry;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white.withOpacity(.5),
      disabledColor: Colors.pink,
      onPressed: () {
        newAlpha.add(entry);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(entry,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
    );
  }

  String allAlphabets() {
    String alpha='';
    if (newAlpha.length>3) {
      newAlpha.forEach((alphabet) {
        alpha = alpha + alphabet;
      });
    }
    newAlpha=[];
    return alpha;
    
  }
}

