import 'package:flutter/material.dart';


class EntryHandler{
  // EntryHandler({this.entryList});
  List<String> entryList = [''];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  void insertItem(key) {
    if (key.length>2){
    String item = key;
    int insertIndex = 0;
    entryList.insert(insertIndex, item);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item,style:TextStyle(color:Colors.white),),
            ),
            SizedBox(width:15),
            Icon(Icons.check_box,color:Colors.green)
          ],
        )
      ),
    ),
  );
}


}

