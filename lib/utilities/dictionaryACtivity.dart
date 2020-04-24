import 'dictionary.dart';

bool checkDictionary(String word, List corpus) {
  bool output = corpus.contains(word.toLowerCase());
  print(output);
  return output;
}

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

bool verifyWord(word, subword) {
  bool output;
  word = word.toLowerCase();
  subword = subword.toLowerCase();

  output = subword == word ? true : false;

  var wordMap = generateWordMap(word);
  print(wordMap);

  for (var alphabet in subword.split('')) {
    output = wordMap.containsKey(alphabet) ? true : false;

    if (wordMap.containsKey(alphabet)) {
      output = wordMap[alphabet] == 0 ? false : true;
      wordMap[alphabet]--;
    }
  }
  output=checkDictionary(subword,Dictionary().book);
  return output;
}
