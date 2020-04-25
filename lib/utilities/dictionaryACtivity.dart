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
  verified=(checker.any((i)=>i==false)?false:true)==(checkDictionary(subword,Dictionary().book)?true:false);
  
  return verified;
}
