import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/core/alphabetState.dart';
import 'package:wordsmith/core/utilities/words.dart';
import 'package:wordsmith/handlers/dataHandlers/dataSources/networkRequest.dart';
import 'package:wordsmith/screens/popUps/dialogs/wordDefinition.dart';
import 'dictionaryActivity.dart';
import 'scoreKeeper.dart';

class EntryHandler {
  ///The entryHandler acts as a binder for many gameplay relating functions
  ///The entryHandler handles thw word creation by calling the [WordGenerator]
  ///It handles the Alphabet Widgets across both single and multiplayer gameplays
  /// it also combines with an alphabetHandler [Alphabet]to control the state of alphabet
  /// widgets
  EntryHandler({this.wordGenerator});

  ///User Game Entries
  String entry;

  /// Game Parent Word from which the subWords are expected
  String gameWord;

  /// An EntryList formed from the entries converted to renderable widgets
  List<Widget> entryList = [];

  /// Alphabet Widgets
  final List<Widget> alphaWidgets = [];

  ///ScoreKeeper keeps track of the player validation count and attached score rendering
  ScoreKeeper scoreKeeper = ScoreKeeper();

  ///Alphabet state instance to handle alphabet widget states
  final alphabetHandler = Alphabet().createState();
  final Words wordGenerator;

  ///Returns the wordGenerator Word
  List<String> getWord() {
    return wordGenerator.getRandom();
  }

  ///Validate the entered word,
  ///if the [returnScore] value is parsed then
  ///the [ScoreKeeper] saves the score of that entry
  ///else it passes and just returns the [bool] outcome
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

  ///insert a value into the [entryList]
  insert(String entry) {
    bool correct = validate(entry: entry, returnScore: true);

    entryList.insert(
      0,
      SinglePlayerEntryCard(correct: correct, entry: entry),
    );
  }
}

class SinglePlayerEntryCard extends StatelessWidget {
  const SinglePlayerEntryCard({
    Key key,
    @required this.correct,
    @required this.entry,
  }) : super(key: key);

  final bool correct;
  final String entry;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Align(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            String definition = await GetDefinition(entry).getData();
            print(definition);
            showDialog(
                context: context,
                child: DefinitionPopUp(
                    word: entry,
                    definition: definition,
                    height: height,
                    width: width));
          },
          child: Card(
            elevation: 24,
            color: Colors.primaries[entry.length + 1 % Colors.primaries.length]
                .withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      entry.toUpperCase(),
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Icon(correct ? Icons.mood : Icons.mood_bad,
                      color: correct ? Colors.green : Colors.red),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
