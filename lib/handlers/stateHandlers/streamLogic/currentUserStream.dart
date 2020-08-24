import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/components/cardComponents/entryCard.dart';
import 'package:wordsmith/components/cardComponents/multiPlayerEntryCard.dart';
import 'package:wordsmith/components/cardComponents/singleEntryCard.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';

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
    @required this.listKey,
  })  : _firestore = firestore,
        super(key: key);

  /// firestore instance
  final Firestore _firestore;

  ///listKey
  final listKey;

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
              entryWidgets.add(Center(
                child: MultiEntryCard(
                  key: ValueKey(activeValidList[index]),
                  correct: activeValidList[index],
                  entry: activeGamesWord[index],
                ),
              ));
            }
          }
          return Expanded(
            child: AnimatedList(
              key: listKey,
              physics: BouncingScrollPhysics(),
              initialItemCount: entryHandler.entryList.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                List listItems = entryHandler.entryList;
                return SizeTransition(
                  sizeFactor: CurvedAnimation(
                      parent: animation, curve: Curves.bounceInOut),
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                        parent: animation, curve: Interval(0.2, 1.0)),
                    child: SinglePlayerEntryCard(
                        key: ValueKey(listItems[index][1]),
                        correct: listItems[index][0],
                        entry: listItems[index][1]),
                  ),
                );
              },
              reverse: true,
              shrinkWrap: true,
            ),
          );
        });
  }
}
