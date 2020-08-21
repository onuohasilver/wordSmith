import 'package:meta/meta.dart';

class AlphabetDetail {
  ///The alphabet data
  String alphabet;

  /// a state declaration of the interactiveness of the accompanying widget
  bool active;

  ///the specific letter map value
  int mapNumber;

  /// [DraggableAlphabet] data model
  AlphabetDetail(
      {@required this.alphabet,
      @required this.active,
      @required this.mapNumber});
}
