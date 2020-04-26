import 'package:flutter/material.dart';
import 'dictionaryActivity.dart';
import 'scoreKeeper.dart';

class EntryHandler {
  String entry;
  List<Widget> entryList = [Text('')];
  ScoreKeeper scoreKeeper= ScoreKeeper();
  
  bool validate({bool score}){
    bool validated=verifyWord('FERMENTATION', entry);
    if (score){scoreKeeper.getScores(validated,entry);}
    return validated;
  }


  insert() {
    entryList.insert(
      0,
      Align(
        child: Card(
            elevation: 24,
            color: Colors.primaries[entry.length + 3 % Colors.primaries.length],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    entry.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.check_box,
                    color: validate(score:false)
                        ? Colors.green
                        : Colors.red),
                SizedBox(width: 15),
              ],
            )),
      ),
    );
  }
}
