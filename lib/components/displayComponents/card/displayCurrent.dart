import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/alphabetTile.dart';
import 'package:wordsmith/utilities/dictionaryActivity.dart';
import 'package:wordsmith/utilities/entryHandler.dart';

class DisplayCurrentEntry extends StatefulWidget {
  const DisplayCurrentEntry({
    Key key,
    @required this.entryHandler,
    @required this.letterMap,
    @required this.streamEntriesCurrentUser,
    @required Firestore firestore,
    @required this.userData,
  })  : _firestore = firestore,
        super(key: key);

  final EntryHandler entryHandler;
  final MappedLetters letterMap;
  final Set<String> streamEntriesCurrentUser;

  final Firestore _firestore;
  final Data userData;

  @override
  _DisplayCurrentEntryState createState() => _DisplayCurrentEntryState();
}

class _DisplayCurrentEntryState extends State<DisplayCurrentEntry> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.lightBlue.withOpacity(.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                child: Icon(Icons.delete_forever,
                    color: Colors.lightBlue, size: 30.0),
                onTap: () {
                  setState(
                    () {
                      widget.entryHandler.alphabetHandler.reset();
                      widget.letterMap.reset();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                    widget.entryHandler.alphabetHandler.newAlpha.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                child: Icon(Icons.send, color: Colors.lightBlue, size: 30.0),
                onTap: () async {
                  ///retrieve all the previously entered words from firestore
                  /// so that it can be merged with the current entry and re-uploaded
                  Map activeGamesMap;
                  await widget._firestore
                      .collection('users')
                      .document(widget.userData.currentUserID)
                      .get()
                      .then((value) => activeGamesMap = value['activeGames']);
                  setState(
                    () {
                      String allAlphabets =
                          widget.entryHandler.alphabetHandler.allAlphabets();
                      print('trying to reset this');
                      widget.entryHandler.alphabetHandler.reset();
                      widget.letterMap.reset();
                      if (!widget.streamEntriesCurrentUser
                          .contains(allAlphabets)) {
                        bool criteria = allAlphabets.length > 3;

                        List currentUserWords = [allAlphabets];
                        List currentUserValidList = [
                          verifyWord(
                              widget.entryHandler.getGameWord(), allAlphabets)
                        ];
                        currentUserWords
                            .addAll(activeGamesMap['currentUserWords']);
                        currentUserValidList
                            .addAll(activeGamesMap['currentUserValidList']);
                        activeGamesMap['currentUserWords'] = currentUserWords;
                        // activeGamesMap['currentUserScore'] =
                        //     widget.entryHandler.scoreKeeper;
                        activeGamesMap['currentUserValidList'] =
                            currentUserValidList;

                        criteria
                            ? widget._firestore
                                .collection('users')
                                .document(widget.userData.currentUserID)
                                .setData({
                                'activeGames': activeGamesMap,
                              }, merge: true)
                            : print('');

                        criteria
                            ? widget.entryHandler.insert(
                                allAlphabets.trimLeft(),
                              )
                            : print('');
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
