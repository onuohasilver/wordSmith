import 'package:meta/meta.dart';

class AlphabetDetail {
  ///The alphabet data
  String alphabet;
  /// a state declaration of the interactiveness of the accompanying widget
  bool active;
  /// [DraggableAlphabet] data model
  AlphabetDetail({@required this.alphabet,@required this.active});
}
