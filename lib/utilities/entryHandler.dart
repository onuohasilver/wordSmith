import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/words.dart';
import 'dictionaryActivity.dart';
import 'scoreKeeper.dart';
import 'alphabets.dart';

class EntryHandler {
  String entry;
  List<Widget> entryList = [];
  ScoreKeeper scoreKeeper = ScoreKeeper();
  final alphabetHandler = Alphabet().createState();
  Words wordGenerator = Words();
  




  List<String> getWord(){
    return wordGenerator.getRandom();
  }

  bool validate({String entry}) {
    bool validated = verifyWord(wordGenerator.allAlphabets(), entry);
    if (validated) {
      scoreKeeper.getScores(validated, entry);
    }

    return validated;
  }

  insert(String entry) {
    bool correct = validate(entry: entry);
    entryList.insert(
      0,
      Align(
        child: Card(
          elevation: 24,
          color: Colors.primaries[entry.length + 3 % Colors.primaries.length]
              .withOpacity(0.4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  entry.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Icon(correct ? Icons.check_box : Icons.cancel,
                  color: correct ? Colors.green : Colors.red),
              SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
