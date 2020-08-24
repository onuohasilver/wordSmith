///Contains the [EntryCard] and the [RowEntryCard]
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EntryCard extends StatelessWidget {
  ///This creates a rendering of the user entries
  ///during game play, it is a container that changes
  ///its color based on the length of the text contained
  ///in its [entry] variable
  EntryCard({this.entry});
  ///The value entered by the user during gameplay
  ///that requires rendering
  final String entry;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Card(
        elevation: 24,
        color: Colors.primaries[entry.length + 3 % Colors.primaries.length]
            .withOpacity(.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                entry.toUpperCase(),
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}

class RowEntryCard extends StatelessWidget {
  ///Expands on the EntryCard to Serve a view
  ///that contains both the entry
  ///and the consequent validation result
  RowEntryCard({this.entryCard, this.validator, entry});

  ///[EntryCard] to be rendered
  final EntryCard entryCard;

  ///[bool] value gotten when [EntryHandler] instance
  ///has duly matched the entry to values in the
  ///dictionary file
  final bool validator;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        entryCard,
        validator
            ? Icon(Icons.mood, color: Colors.green[700])
            : Icon(
                Icons.mood_bad,
                color: Colors.red[700],
              )
      ],
    );
  }
}
