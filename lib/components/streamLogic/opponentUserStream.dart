import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class OpponentUserStream extends StatelessWidget {
  const OpponentUserStream({
    Key key,
    @required Firestore firestore,
    @required this.widget,
    @required this.streamEntriesOpponent,
    @required this.entryHandler,
    this.opponentUserID,
  })  : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;
  final MultiLevelOne widget;
  final Set<String> streamEntriesOpponent;
  final String opponentUserID;
  final EntryHandler entryHandler;

  @override
  Widget build(BuildContext context) {
    Data userData=Provider.of<Data>(context);
      return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('users')
            .document('FqvaoKC4vHTLuTGHc3bwe51etfa2')
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
