import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';

class DraggableAlphabet extends StatefulWidget {
  DraggableAlphabet(
      {this.alphabet,
      this.active,
      this.onPressed,
      this.sizeRatio,
      this.bgTile,
      this.noPadding});

  /// [bool] active manages the state of the UI of the button
  /// if the button has been triggered the button color is transformed
  /// to a completely [Colors.white12] text.
  final bool active;

  /// [String] alphabet: is the child of the [AlphabetButton]
  /// the actual alphabet to be displayed
  final String alphabet;

  /// [Function] a function to be triggered on the button press detected.
  final Function onPressed;

  ///sizeRatio to determinge the proportion to the queried device size
  final double sizeRatio;

  ///Background tile image location
  final String bgTile;

  ///no padding [null]removes all forms of padding if set to true
  final double noPadding;
  @override
  _DraggableAlphabetState createState() => _DraggableAlphabetState();
}

class _DraggableAlphabetState extends State<DraggableAlphabet> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: AlphabetDetail(alphabet: widget.alphabet),
      feedback: AlphabetButton(
        alphabet: widget.alphabet,
        active: widget.active,
        onPressed: widget.onPressed,
        sizeRatio: .6,
        bgTile: widget.bgTile,
        noPadding: widget.noPadding,
      ),
      childWhenDragging: AlphabetButton(
        alphabet: widget.alphabet,
        active: true,
        onPressed: widget.onPressed,
        sizeRatio: widget.sizeRatio,
        bgTile: widget.bgTile,
        noPadding: widget.noPadding,
      ),
      child: AlphabetButton(
        alphabet: widget.alphabet,
        active: widget.active,
        onPressed: widget.onPressed,
        sizeRatio: widget.sizeRatio,
        bgTile: widget.bgTile,
        noPadding: widget.noPadding,
      ),
    );
  }
}
