import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/entryCard.dart';
import 'package:wordsmith/components/cardComponents/multiPlayerEntryCard.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';


class OpponentUserStream extends StatelessWidget {
  /// A StreamBuilder that listens to the changes
  /// in the firestore [activeGames] of the opponent user
  /// and returns a list view containing [MultiEntryCard] widgets
  /// showing the contents of the users game session
  const OpponentUserStream({
    Key key,
    @required Firestore firestore,
    @required this.streamEntriesOpponent,
    @required this.entryHandler,
    this.opponentUserID,
  })  : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;

  ///this is meant to be a [Set] of all the current user's entries
  ///in essence(meant to strip away duplicates without the stress of an if block)
  ///but it is currently deprecated. however I am leaving it in here for posterity sake
  ///as I might need it before long. haha
  final Set<String> streamEntriesOpponent;

  /// Opponent User ID
  final String opponentUserID;

  ///EntryHandler point for the current game session
  final EntryHandler entryHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('users')
            .document(opponentUserID)
            .snapshots(),
        builder: (context, snapshot) {
          List<Widget> entryWidgets = [];

          if (snapshot.hasData) {
            dynamic activeGamesWord =
                snapshot.data['activeGames']['currentUserWords'];
            dynamic activeValidList =
                snapshot.data['activeGames']['currentUserValidList'];
            for (int index = 0; index < activeGamesWord.length; index++) {
              entryWidgets.add(
               Center(
                 child: MultiEntryCard(
                  correct: activeValidList[index],
                  entry: activeGamesWord[index],
                  
                  
              ),
               )
              );
            }
          }
          return Expanded(
              child: ListView.builder(
                  itemCount: entryWidgets.length,
                  itemBuilder: (context, index) {
                    return entryWidgets[index];
                  }));
        });
  }
}
