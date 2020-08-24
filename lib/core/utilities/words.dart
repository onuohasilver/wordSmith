import 'package:wordsmith/handlers/dataHandlers/dataSources/wordSource.dart';

class Words {
  ///word retrieval class for initalizing game play
  Words({this.index});

  ///[wordCollection] index of the word to be retrieved
  final int index;

  List<List<String>> wordCollection = List.generate(
      book.length, (index) => book[index].toUpperCase().split(''));

  ///retrieve a not particularly random word with the given [index]
  List<String> getRandom() {
    return wordCollection[index];
  }

  ///shrink  [List<String>] of alphabets to a single [String] object
  String allAlphabets() {
    String collectAlphabet = '';
    wordCollection[index].forEach((alphabet) {
      collectAlphabet = collectAlphabet + alphabet;
    });
    return collectAlphabet;
  }
}
