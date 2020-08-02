import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordsmith/handlers/dataHandlers/dataSources/networkRequest.dart';
import 'package:wordsmith/screens/popUps/dialogs/wordDefinition.dart';

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
               borderRadius:BorderRadius.circular(10),
                          child: Container(
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(5),
                   image: DecorationImage(
              image: AssetImage('assets/pngwave(2).png'), fit: BoxFit.cover)),
                // color: Colors.primaries[entry.length + 1 % Colors.primaries.length]
                //     .withOpacity(0.4),
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
        ),
      ),
    );
  }
}
