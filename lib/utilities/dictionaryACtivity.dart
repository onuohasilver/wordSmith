
dynamic generateWordMap(word) {
  var wordMap = {};
  for (var alphabet in word.split('')) {
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
  word = word.toUpperCase();
  subword = subword.toUpperCase();

  output = subword == word ? true : false;

  var wordMap = generateWordMap(word);
  print(wordMap);

  for (var alphabet in subword.split('')) {
    output = wordMap.containsKey(alphabet) ? true : false;

    if (wordMap.containsKey(alphabet)) {
      output = wordMap[alphabet] == 0? false:true;
      wordMap[alphabet]--;
    }
  }
  return output;
}
