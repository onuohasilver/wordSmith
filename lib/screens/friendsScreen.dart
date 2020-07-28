import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/displayComponents/card/userCard.dart';
import 'package:wordsmith/userProvider/themeData.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/constants.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final _firestore = Firestore.instance;
  List<String> friendList = [];
  List<dynamic> friends = [];
  List<String> friendUserNames;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Data userData = Provider.of<Data>(context);
    final theme = Provider.of<AppThemeData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

   
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print(userData.currentUserID);

                final users = snapshot.data.documents;
                friendUserNames = [];

                for (var user in users) {
                  final String userID = user.data['userid'];
                  final String userName = user.data['username'];

                  if (userData.currentUserID == userID) {
                    friends = user.data['friends'];
                    // print(friends);

                  }
                  if (friends.contains(userID)) {
                    print(friends);
                    friendUserNames.add(userName);
                  }
                }
              }

              return Container(
                height: height,
                width: width,
                decoration: theme.background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      blurBox,
                      Expanded(
                        child: GridView.builder(
                          itemCount: friendUserNames.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: width * .3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return UserCard(
                                width: width, userName: friendUserNames[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

