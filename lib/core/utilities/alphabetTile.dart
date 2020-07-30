///Model for Letter and current State information
class LetterActivePair {
  String word;
  bool active;
  LetterActivePair(this.word, this.active);
}
///Mapping the letters to differentiate where 
///the letters occur multiple times
class MappedLetters {
  MappedLetters({this.alphabets});
  final List<String> alphabets;
  List<LetterActivePair> letterPairs = [];
  Map<String, bool> map1 = {};
  Map<String, bool> map2 = {};
  Map<String, bool> map3 = {};
  Map<String, bool> map4 = {};
  printIt(){
    print(map1);
    print(map2);
    print(map3);
    print(map4);
  }
  ///reset the states of each of the mapped
  ///letter-active pairs
  reset(){
    map1.keys.forEach((key) {
    map1[key] = true;
  });
  map2.keys.forEach((key) {
    map2[key] = true;
  });
  map3.keys.forEach((key) {
    map3[key] = true;
  });
  map4.keys.forEach((key) {
    map4[key] = true;
  });
  }

  ///generates the mappings of the letter-active pairs
  ///using an oddly constructed for-loop
  //TODO: Improve this ridiculous loop boy. looks laggy.
  getMapping() {
    for (var letter in alphabets) {
      letterPairs.add(LetterActivePair(letter, true));
    }
    letterPairs.forEach((letter) {
      if (!map1.containsKey(letter.word)) {
        map1['${letter.word}'] = letter.active;
      } else {
        if (!map2.containsKey(letter.word)) {
          map2['${letter.word}'] = letter.active;
        } else {
          if (!map3.containsKey(letter.word)) {
            map3['${letter.word}'] = letter.active;
          } else {
            if (!map4.containsKey(letter.word)) {
              map4['${letter.word}'] = letter.active;
            }
          }
        }
      }
    });
  }
}

