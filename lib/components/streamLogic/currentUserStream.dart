import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/components/displayComponents/card/entryCard.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class CurrentUserStream extends StatelessWidget {
  /// A StreamBuilder that listens to the changes
  /// in the firestore [activeGames] of the current user
  /// and returns a list view containing [RowEntryCard] widgets
  /// showing the contents of the users game session
  const CurrentUserStream({
    Key key,
    @required Firestore firestore,
    @required this.userData,
    @required this.streamEntriesCurrentUser,
    @required this.entryHandler,
  })  : _firestore = firestore,
        super(key: key);

  /// firestore instance
  final Firestore _firestore;

  ///User Provider data
  final Data userData;

  ///this is meant to be a [Set] of all the current user's entries
  ///in essence(meant to strip away duplicates without the stress of an if block)
  ///but it is currently deprecated. however I am leaving it in here for posterity sake
  ///as I might need it before long. haha
  final Set<String> streamEntriesCurrentUser;

  ///EntryHandler point for the current game session
  final EntryHandler entryHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('users')
            .document(userData.currentUserID)
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
                RowEntryCard(
                  entry: activeGamesWord[index],
                  entryCard: EntryCard(entry: activeGamesWord[index]),
                  validator: activeValidList[index],
                ),
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
