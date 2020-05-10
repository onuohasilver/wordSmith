import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseOpponent extends StatefulWidget {
  @override
  _ChooseOpponentState createState() => _ChooseOpponentState();
}

class _ChooseOpponentState extends State<ChooseOpponent> {
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String loggedInUserId;
  getUserDetails() async {
    final loggedInUser = await _auth.currentUser();
    loggedInUserId = loggedInUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    List<String> friendList = [];
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.blueAccent],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Card(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Friends',
                      style: TextStyle(color: Colors.white),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('users').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final users = snapshot.data.documents;
                            List<Widget> entryWidgets = [];
                            List<dynamic> friends=[];

                            for (var user in users) {
                              final String userID = user.data['userid'];
                              final String userName = user.data['username'];
                              print(userID);
                              if (loggedInUserId == userID) {
                                friends = user.data['friends'];
                              } 
                              if (friends.contains(userID)) {
                                entryWidgets.add(
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 3,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text('Play'),
                                                  onPressed: () => Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          'MultiLevelOne'),
                                                  elevation: 12,
                                                ),
                                                RaisedButton(
                                                  child: Text('Remove'),
                                                  onPressed: () {},
                                                  elevation: 12,
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          left: 9, right: 9, top: 5),
                                      elevation: 6,
                                      color: Colors.greenAccent.withOpacity(.4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '$userName !'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return Expanded(
                                child: ListView(
                                    reverse: false, children: entryWidgets));
                          }
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'All Users',
                      style: TextStyle(color: Colors.white),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('users').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final users = snapshot.data.documents;
                            List<Widget> entryWidgets = [];
                            List<dynamic> friends;

                            for (var user in users) {
                              final String userID = user.data['userid'];
                              final String userName = user.data['username'];
                              if (loggedInUserId == userID) {
                                friends = user.data['friends'];
                              } else {
                                friends = [];
                              }

                              if (!(friends.contains(userID)) &
                                  (loggedInUserId != userID)) {
                                entryWidgets.add(
                                  GestureDetector(
                                    onTap: () {
                                      print(loggedInUserId);
                                      print(friends);
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            elevation: 3,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text('Play'),
                                                  onPressed: () => Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          'MultiLevelOne'),
                                                  elevation: 12,
                                                ),
                                                RaisedButton(
                                                  child: Text('Add Friend'),
                                                  onPressed: () {
                                                    for (var friend
                                                        in friends) {
                                                      friendList.add(friend);
                                                    }

                                                    friendList.add(userID);

                                                    print(userID);
                                                    _firestore
                                                        .collection('users')
                                                        .document(
                                                            loggedInUserId)
                                                        .setData({
                                                      'friends': friendList
                                                    }, merge: true);
                                                  },
                                                  elevation: 12,
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          left: 9, right: 9, top: 5),
                                      elevation: 6,
                                      color: Colors.blueAccent.withOpacity(.4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '$userName '.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return Expanded(
                                child: ListView(
                                    reverse: false, children: entryWidgets));
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
