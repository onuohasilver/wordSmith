import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Alphabet extends StatefulWidget {
  @override
  _AlphabetState createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
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

  String allAlphabets() {
    String alpha = '';

    if (newAlpha.length > 3) {
      newAlpha.forEach((alphabet) {
        alpha = alpha + alphabet;
      });
    }
    return alpha;
  }

  void reset() {
    newAlpha = [];
  }
}

class AlphabetButton extends StatelessWidget {
  AlphabetButton({this.alphabet, this.active, this.onPressed});
  final bool active;
  final String alphabet;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(alphabet,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 17)),
          ),
          color: active ? Colors.white.withOpacity(.6) : Colors.transparent),
    );
  }
}
