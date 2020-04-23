import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/entryHandler.dart';
class LevelOneEntry extends StatefulWidget {
  @override
  _LevelOneEntryState createState() => _LevelOneEntryState();
}

class _LevelOneEntryState extends State<LevelOneEntry> {
  String entry;
  EntryHandler entryHandler=EntryHandler();
  

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
                            key: entryHandler.listKey,
                            initialItemCount: entryHandler.entryList.length,
                            itemBuilder: (context, index, animation) {
                              return entryHandler.buildItem(entryHandler.entryList[index], animation);
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
                          entryHandler.insertItem(entry);
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

