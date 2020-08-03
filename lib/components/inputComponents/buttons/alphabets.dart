import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///[AlphabetButton] creates a [Card] that is wrapped with
///a [GestureDetector] it is usually used in conjunction with a [LetterMap]
///and an [Alphabet] state handler
class AlphabetButton extends StatelessWidget {
  AlphabetButton({this.alphabet, this.active, this.onPressed});

  /// [bool] active manages the state of the UI of the button
  /// if the button has been triggered the button color is transformed
  /// to a completely [Colors.white12] text.
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
                  child: Container(
            decoration: BoxDecoration(image:DecorationImage(   image: AssetImage('assets/pngwave.png'), fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(alphabet,
                    style: GoogleFonts.poppins(
                      color: active?Colors.white:Colors.white12,
                        fontWeight: FontWeight.bold, fontSize: 23,)),
              ),
             ),
        ),
      ),
    );
  }
}

//  color: active ? Colors.white.withOpacity(.6) : Colors.transparent
