import 'package:flutter/material.dart';

class LevelOneEntry extends StatefulWidget {
  @override
  _LevelOneEntryState createState() => _LevelOneEntryState();
}

class _LevelOneEntryState extends State<LevelOneEntry> {
  String entry;

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
                Align(
                  alignment: Alignment.topRight,
                  child: Card(
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '00:30',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Card(
                      color: Colors.white.withOpacity(.2),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('FERMENTATION',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold)))
                        ],
                      )),
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
                        onChanged: (value){
                          entry=value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          print(entry);
                        },
                        child: Icon(Icons.send,
                            color: Colors.lightBlue, size: 25.0))
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
