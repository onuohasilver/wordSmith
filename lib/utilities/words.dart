import 'dart:math';

class Words {
  int index=Random().nextInt(9);
  List<List<String>> wordCollection = [
    ['F', 'E', 'R', 'M', 'E', 'N', 'T', 'A', 'T', 'I', 'O', 'N'],
    ['H', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['C', 'O', 'R', 'P', 'O', 'R', 'A', 'T', 'E'],
    ['H', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['C', 'O', 'R', 'P', 'O', 'R', 'A', 'T', 'E'],
    ['H', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['C', 'O', 'R', 'P', 'O', 'R', 'A', 'T', 'E'],
    ['H', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['C', 'P', 'A', 'P', 'O', 'D', 'A', 'T', 'E'],
    
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

