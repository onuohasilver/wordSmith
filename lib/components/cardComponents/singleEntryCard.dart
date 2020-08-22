import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/alphabets.dart';
import 'package:wordsmith/handlers/dataHandlers/dataModels/alphabetModel.dart';
import 'package:wordsmith/handlers/dataHandlers/dataSources/networkRequest.dart';
import 'package:wordsmith/screens/popUps/dialogs/wordDefinition.dart';

class SinglePlayerEntryCard extends StatelessWidget {
  ///Displays a card cantaining [AlphabetButton] widgets
  ///generated with the text entered by the user
  ///during a singleplayer game session
  ///contains both the [entry] and also the validation result [correct
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
    List<Widget> alphabetWidgets = List.generate(
      entry.length,
      (index) {
        AlphabetDetail alphabetDetail = AlphabetDetail(
            alphabet: entry[index], active: true, mapNumber: null);
        return AlphabetButton(
          alphabetDetail: alphabetDetail,
          onPressed: null,
          sizeRatio: .5,
        );
      },
    );
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              String definition = await GetDefinition(entry).getData();

              showDialog(
                  context: context,
                  child: DefinitionPopUp(
                      word: entry,
                      definition: definition,
                      height: height,
                      width: width));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                // color: Colors.primaries[entry.length + 1 % Colors.primaries.length]
                //     .withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: alphabetWidgets,
                      ),
                      Material(
                        type: MaterialType.circle,
                        color: Colors.white,
                        child: Icon(correct ? Icons.mood : Icons.mood_bad,
                            color: correct ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
