import 'package:wordsmith/handlers/dataHandlers/dataSources/wordSource.dart';

class Words {
  Words({this.index});
  final int index;
  
  List<List<String>> wordCollection = List.generate(
      book.length, (index) => book[index].toUpperCase().split(''));


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
