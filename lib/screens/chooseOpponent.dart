import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordsmith/utilities/components.dart';
import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';

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
                            List<dynamic> friends = [];

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
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 3,
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                      child: UserCard(
                                          userName: userName,
                                          color: Colors.greenAccent)),
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
                            List<dynamic> friends = [];
                            String loggedInUserName;

                            for (var user in users) {
                              final String userID = user.data['userid'];
                              final String userName = user.data['username'];
                              if (loggedInUserId == userID) {
                                friends = user.data['friends'];
                                loggedInUserName=user.data['username'];
                              }

                              if (!(friends.contains(userID)) &
                                  (loggedInUserId != userID)) {
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
                                                  onPressed: () =>
                                                      Navigator.pushReplacement(
                                                          (context),
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                    return MultiLevelOne(
                                                      opponentName: userName,
                                                      opponentID:userID,
                                                      currentUserName:loggedInUserName,
                                                    );
                                                  })),
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

                                                    _firestore
                                                        .collection('users')
                                                        .document(
                                                            loggedInUserId)
                                                        .setData({
                                                      'friends': friendList
                                                    }, merge: true);
                                                    friendList.clear();
                                                  },
                                                  elevation: 12,
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                    child: UserCard(
                                        userName: userName,
                                        color: Colors.blueAccent),
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
