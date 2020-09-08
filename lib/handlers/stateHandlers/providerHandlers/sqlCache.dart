import 'package:flutter/cupertino.dart';
import 'package:wordsmith/core/utilities/entryHandler.dart';
import 'package:wordsmith/handlers/dataHandlers/dataSources/sqldbHandler.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/gameplayData.dart';

class SqlCache extends ChangeNotifier {
  /// List containing the map of returned db query
  List dbCache = [];

  /// load data into  the [dbCache]
  void cacheDBresponse(value) async {
    dbCache = value;
    notifyListeners();
  }

  void updateDb(
      EntryHandler entryHandler, widget, GamePlayData gamePlay) async {
    await DatabaseHelper.instance.update(row: {
      DatabaseHelper.score: entryHandler.scoreKeeper.scoreValue(),
      DatabaseHelper.levelID: widget.wordIndex,
      DatabaseHelper.stars: gamePlay.progress
    }, tableName: DatabaseHelper.levelTable);
  }

  void insertNew(
      EntryHandler entryHandler, widget, GamePlayData gamePlay) async {
    await DatabaseHelper.instance.insert(row: {
      DatabaseHelper.score: entryHandler.scoreKeeper.scoreValue(),
      DatabaseHelper.levelID: widget.wordIndex,
      DatabaseHelper.stars: gamePlay.progress
    }, tableName: DatabaseHelper.levelTable);
  }
}
