import 'dictionary.dart';

///check if the given word is in the dictionary corpus
bool checkDictionary(String word, List corpus) {
  bool output = corpus.contains(word.toLowerCase());
  return output;
}
///creates a wordMap such that
///the word is deconstructed in to a map object
dynamic generateWordMap(String word) {
  var wordMap = {};
  for (var alphabet in word.toLowerCase().split('')) {
    if (wordMap.containsKey(alphabet)) {
      wordMap[alphabet]++;
    } else {
      wordMap[alphabet] = 1;
    }
  }
  return wordMap;
}
///uses the logic suggested by Kesa Oluwafunmilola
///to check whether a word is a subword of another
///by counting the number of unique letters and their occurences
///to see if it can be reconstructed from a map of the 
///parent word
bool verifyWord(word, subword) {
  bool output;
  bool verified;
  word = word.toLowerCase();
  subword = subword.toLowerCase();

  output = subword == word ? true : false;

  var wordMap = generateWordMap(word);
  print(wordMap);
  List<bool> checker = [];
  for (var alphabet in subword.split('')) {
    if (wordMap.containsKey(alphabet)) {
      output = wordMap[alphabet] == 0 ? false : true;
      wordMap[alphabet]--;
      checker.add(output);
    } else {
      output = false;
      checker.add(output);
    }
  }
  bool _checkerResult = (checker.any((i) => i == false) ? false : true);
  bool _dictionaryResult =
      checkDictionary(subword, Dictionary().book) ? true : false;
/// check if the resulting word satisfies both the dictionary check and the 
/// subword checker
  verified = (_checkerResult & _dictionaryResult);

  return verified;
}
