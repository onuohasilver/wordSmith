import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';

///Create and Maintain an alphabet button UI
class AlphabetButton extends StatelessWidget {
  ///[AlphabetButton] creates a [Card] that is wrapped with
  ///a [GestureDetector] it is usually used in conjunction with a [LetterMap]
  ///and an [Alphabet] handler which is used to reflect the state changes
  AlphabetButton(
      {this.onPressed,
      this.sizeRatio,
      this.bgTile,
      this.noPadding,
      this.textColor,
      @required this.alphabetDetail});

  /// [bool] active manages the state of the UI of the button
  /// if the button has been triggered the button color is transformed
  /// to a completely [Colors.white12] text.
  /// [String] alphabet: is the child of the [AlphabetButton]
  /// the actual alphabet to be displayed
  final AlphabetDetail alphabetDetail;

  /// [Function] a function to be triggered on the button press detected.
  final Function onPressed;

  ///sizeRatio to determinge the proportion to the queried device size
  final double sizeRatio;

  ///Background tile image location
  final String bgTile;

  ///optional textColor
  final Color textColor;

  ///no padding [null]removes all forms of padding if set to true
  final double noPadding;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 5,
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Opacity(
              opacity: alphabetDetail.active ? 1 : .5,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bgTile ?? 'assets/pngwave(1).png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: noPadding ?? width * .03 * (sizeRatio ?? 1),
                      horizontal: noPadding ?? width * .05 * (sizeRatio ?? 1)),
                  child: Text(alphabetDetail.alphabet,
                      style: GoogleFonts.poppins(
                        color: textColor ??
                            (alphabetDetail.active
                                ? Colors.brown[800]
                                : Colors.black26),
                        fontWeight: FontWeight.w800,
                        fontSize: width * .085 * (sizeRatio ?? 1),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
