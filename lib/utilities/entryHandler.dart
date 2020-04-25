import 'package:flutter/material.dart';
import 'dictionaryActivity.dart';

class EntryHandler{
  
  List<String> entryList = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  void insertItem(key) {
    if (key.length>2){
    String item = key;
    int insertIndex = 0;
    entryList.insert(insertIndex, item.toLowerCase());
    listKey.currentState.insertItem(insertIndex);}
  }



Widget buildItem(String item, Animation animation,) {
  IconData icon=verifyWord('FERMENTATION',item)?Icons.check_circle:Icons.cancel;
  
  return SizeTransition(
    sizeFactor: animation,
    child: Align(
          alignment: Alignment.center,
          child: Card(
            elevation: 24,
            color:Colors.primaries[item.length+1 % Colors.primaries.length],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width:15),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(item.toUpperCase(),style:TextStyle(color:Colors.white,fontSize: 14),),
            ),
            Icon(icon,
            color:verifyWord('FERMENTATION',item)?Colors.green:Colors.red),
            SizedBox(width:15),
            
          ],
        )
      ),
    ),
  );
}


}

