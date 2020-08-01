import 'package:wordsmith/core/utilities/dictionary.dart';

class Words {
  Words({this.index});
  final int index;

  List<List<String>> wordCollection = List.generate(
      Dictionary().book.length, (index) => Dictionary().book[index].split(''));

  List<String> getRandom() {
    return wordCollection[index];
  }

  String allAlphabets() {
    String collectAlphabet = '';
    wordCollection[index].forEach((alphabet) {
      collectAlphabet = collectAlphabet + alphabet;
    });
    return collectAlphabet;
  }
}
