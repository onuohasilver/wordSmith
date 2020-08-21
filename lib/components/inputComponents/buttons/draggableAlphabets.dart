import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';

class DraggableAlphabet extends StatefulWidget {
  DraggableAlphabet({
    this.onPressed,
    this.sizeRatio,
    this.bgTile,
    this.noPadding,
    @required this.alphabetDetail,
  });

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

  ///no padding [null]removes all forms of padding if set to true
  final double noPadding;
  @override
  _DraggableAlphabetState createState() => _DraggableAlphabetState();
}

class _DraggableAlphabetState extends State<DraggableAlphabet> {
  @override
  Widget build(BuildContext context) {
    String alphabet = widget.alphabetDetail.alphabet;
    bool active = widget.alphabetDetail.active;
    int mapNumber = widget.alphabetDetail.mapNumber;
    return Draggable(
      data: AlphabetDetail(
          alphabet: alphabet, active: active, mapNumber: mapNumber),
      feedback: AlphabetButton(
        alphabet: alphabet,
        active: active,
        onPressed: widget.onPressed,
        sizeRatio: .6,
        bgTile: widget.bgTile,
        noPadding: widget.noPadding,
      ),
      childWhenDragging: AlphabetButton(
        alphabet: alphabet,
        active: true,
        onPressed: widget.onPressed,
        sizeRatio: widget.sizeRatio,
        bgTile: widget.bgTile,
        noPadding: widget.noPadding,
      ),
      child: AlphabetButton(
        alphabet: alphabet,
        active: active,
        onPressed: widget.onPressed,
        sizeRatio: widget.sizeRatio,
        bgTile: widget.bgTile,
        noPadding: widget.noPadding,
      ),
    );
  }
}
