import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/words.dart';
import 'dictionaryActivity.dart';
import 'scoreKeeper.dart';
import 'package:wordsmith/components/displayComponents/buttons/alphabets.dart';

class EntryHandler {
  EntryHandler({this.wordGenerator});

  String entry;
  String gameWord;
  List<Widget> entryList = [];
  final List<Widget> alphaWidgets = [];
  ScoreKeeper scoreKeeper = ScoreKeeper();
  final alphabetHandler = Alphabet().createState();
  final Words wordGenerator;

  List<String> getWord() {
    return wordGenerator.getRandom();
  }

  bool validate({String entry, @required bool returnScore}) {
    gameWord = wordGenerator.allAlphabets();
    bool validated = verifyWord(gameWord, entry);
    if (returnScore) {
      if (validated) {
        scoreKeeper.getScores(validated, entry);
      }
    }
    return validated;
  }

  String getGameWord() {
    return wordGenerator.allAlphabets();
  }

  insert(String entry) {
    bool correct = validate(entry: entry, returnScore: true);

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
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  entry.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Icon(correct ? Icons.mood : Icons.mood_bad,
                  color: correct ? Colors.green : Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}
