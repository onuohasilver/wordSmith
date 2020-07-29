import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class CurrentUserStream extends StatelessWidget {
  CurrentUserStream(
      {Key key,
      @required Firestore firestore,
      @required this.userData,
      @required this.streamEntriesCurrentUser,
      @required this.entryHandler,
      this.entryList})
      : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;
  final Data userData;
  final Set<String> streamEntriesCurrentUser;
  final EntryHandler entryHandler;
  final List entryList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection(userData.currentUserID)
            .document('activeGames')
            .snapshots(),
        builder: (context, snapshot) {
          List<Widget> entryWidgets = [];
          if (snapshot.hasData) {}
          return Expanded(child: ListView(children: entryWidgets));
        });
  }
}
