import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Stateful Aplphabet handler that is initialised for use by
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
  /// 'acute'
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

///[AlphabetButton] creates a [Card] that is wrapped with
///a [GestureDetector] it is usually used in conjunction with a [LetterMap]
///and an [Alphabet] state handler
class AlphabetButton extends StatelessWidget {
  AlphabetButton({this.alphabet, this.active, this.onPressed});

  /// [bool] active manages the state of the UI of the button
  /// if the button has been triggered the button color is transformed
  /// to a completely transparent [Card] with a minor elevation backdrop.
  final bool active;

  /// [String] alphabet: is the child of the [AlphabetButton]
  /// the actual alphabet to be displayed
  final String alphabet;

  /// [Function] a function to be triggered on the button press detected.
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
