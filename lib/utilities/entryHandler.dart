import 'package:flutter/material.dart';


class EntryHandler{
  
  List<String> entryList = [''];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  void insertItem(key) {
    if (key.length>2){
    String item = key;
    int insertIndex = 0;
    entryList.insert(insertIndex, item.toLowerCase());
    listKey.currentState.insertItem(insertIndex);}
  }



Widget buildItem(String item, Animation animation) {
  return SizeTransition(
    sizeFactor: animation,
    child: Align(
          alignment: Alignment.center,
          child: Card(
            color:Colors.black,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width:15),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(item.toUpperCase(),style:TextStyle(color:Colors.white,fontSize: 14),),
            ),
            SizedBox(width:15),
            
          ],
        )
      ),
    ),
  );
}


}

