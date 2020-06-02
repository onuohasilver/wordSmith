import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/screens/joinGameScreen.dart';
import 'package:wordsmith/screens/setupGameScreen.dart';
import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
import 'package:wordsmith/components/displayComponents/card/cards.dart';
import 'package:wordsmith/userProvider/userData.dart';

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
    final appData = Provider.of<Data>(context);
    List<String> friendList = [];
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        decoration: appData.theme,
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
                          } else {
                            return CircularProgressIndicator();
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
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            final users = snapshot.data.documents;
                            List<Widget> entryWidgets = [];
                            List<dynamic> friends = [];
                            String loggedInUserName;
                            String loggedInUserID;

                            for (var user in users) {
                              final String userID = user.data['userid'];
                              final String userName = user.data['username'];
                              if (loggedInUserId == userID) {
                                friends = user.data['friends'];
                                loggedInUserName = user.data['username'];
                                loggedInUserID = user.data['userid'];
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
                                            content: Wrap(
                                              alignment: WrapAlignment.center,
                                              // mainAxisAlignment:
                                              // MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SlimButton(
                                                  color: Colors.lightBlueAccent,
                                                  useWidget: false,
                                                  label: 'SetUp Game',
                                                  onTap: () =>
                                                      Navigator.pushReplacement(
                                                    (context),
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return SetupGameScreen(
                                                            opponentName:
                                                                userName,
                                                            opponentID: userID,
                                                            currentUserName:
                                                                loggedInUserName,
                                                            currentUserID:
                                                                loggedInUserID,
                                                          );
                                                        },
                                                        maintainState: false),
                                                  ),
                                                ),
                                                SlimButton(
                                                  label: 'Add Friend',
                                                  color: Colors.lightBlueAccent,
                                                  useWidget: false,
                                                  onTap: () {
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
                                                ),
                                                SlimButton(
                                                  color: Colors.lightBlueAccent,
                                                  useWidget: false,
                                                  label: 'Join Game',
                                                  onTap: () =>
                                                      Navigator.pushReplacement(
                                                    (context),
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return JoinGameScreen(
                                                            opponentName:
                                                                userName,
                                                            opponentID: userID,
                                                            currentUserName:
                                                                loggedInUserName,
                                                            currentUserID:
                                                                loggedInUserID,
                                                          );
                                                        },
                                                        maintainState: false),
                                                  ),
                                                ),
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
