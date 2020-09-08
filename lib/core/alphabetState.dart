import 'package:flutter/material.dart';

///Stateful Alphabet handler that is initialised for use by
///calling [Alphabet().createState()]
///The [createState()] adds an awareness of the widget state to
///the widget tree and enables overlaying the [AlphabetButton] widget
///it serves as the [alphabetHandler] for the [EntryHandler()] widget.

class Alphabet extends StatefulWidget {
  @override
  _AlphabetState createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
  ///Alphabet List that contains all the User triggered entries
  List<String> newAlpha = [];
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

  ///combine the [String] alphabets contained in the [newAlpha]
  ///into one concantenated String
  ///
  ///A [newAlpha] of ['a','c','u','t','e'] returns a value of
  /// ['acute']
  String allAlphabets() {
    String alpha = '';

    if (newAlpha.length > 3) {
      newAlpha.forEach((alphabet) {
        alpha = alpha + alphabet;
      });
    }
    return alpha;
  }

  ///reset the [newAlpha] to an empty [List<String>]
  void reset() {
    newAlpha = [];
  }
}
