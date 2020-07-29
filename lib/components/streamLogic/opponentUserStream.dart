import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class OpponentUserStream extends StatelessWidget {
  const OpponentUserStream({
    Key key,
    @required Firestore firestore,
    @required this.widget,
    @required this.streamEntriesOpponent,
    @required this.entryHandler,
  })  : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;
  final MultiLevelOne widget;
  final Set<String> streamEntriesOpponent;
  final EntryHandler entryHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('entry')
            .document('opponentGameID')
            .snapshots(),
        builder: (context, snapshot) {
          List<Widget> entryWidgets = [];
          if (!snapshot.hasData) {
            return Container();
          } else {}
          return Expanded(child: ListView(children: entryWidgets));
        });
  }
}
