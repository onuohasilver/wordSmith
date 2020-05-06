import 'dart:math';

class Words {
  int index=Random().nextInt(3);
  List<List<String>> wordCollection = [
    ['f', 'e', 'r', 'm', 'e', 'n', 't', 'a', 't', 'i', 'o', 'n'],
    ['h', 'o', 'p', 'e', 'l', 'e', 's', 's'],
    ['c', 'o', 'r', 'p', 'o', 'r', 'a', 't', 'e'],
    ['c', 'h', 'o', 'c', 'o', 'l', 'a', 't', 'e']
  ];

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

