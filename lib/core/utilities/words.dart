

class Words {
  Words({this.index});
  final int index;
  
  List<List<String>> wordCollection = [
    ['Z', 'E', 'R', 'M', 'E', 'N', 'T', 'A', 'T', 'I', 'O', 'N'],
    ['F', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['A', 'O', 'R', 'P', 'O', 'R', 'A', 'T', 'E'],
    ['X', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['Y', 'O', 'R', 'Q', 'N', 'R', 'A', 'T', 'E'],
    ['P', 'O', 'P', 'E', 'L', 'E', 'S', 'S'],
    ['C', 'Q', 'W', 'R', 'E', 'A', 'A', 'T', 'E'],
    ['N', 'O', 'W', 'E', 'L', 'E', 'S', 'S'],
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
