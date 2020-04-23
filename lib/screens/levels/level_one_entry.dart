import 'package:flutter/material.dart';

class LevelOneEntry extends StatefulWidget {
  @override
  _LevelOneEntryState createState() => _LevelOneEntryState();
}

class _LevelOneEntryState extends State<LevelOneEntry> {
  String entry;
  List<String> entryList = [''];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void insertItem(key) {
    if (key.length>2){
    String item = key;
    int insertIndex = 0;
    entryList.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage('assets/level_one_entry.jpg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Card(
                        color: Colors.red,
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.arrow_back, color: Colors.white)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Card(
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '00:30',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Card(
                    color: Colors.white.withOpacity(.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            'FERMENTATION',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: AnimatedList(
                            key: _listKey,
                            initialItemCount: entryList.length,
                            itemBuilder: (context, index, animation) {
                              return buildItem(entryList[index], animation);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Enter Word',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          entry = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          insertItem(entry);
                        },
                        child: Icon(Icons.casino,
                            color: Colors.lightBlue, size: 30.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
