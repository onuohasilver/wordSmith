import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/friendUserCard.dart';
import 'package:wordsmith/components/cardComponents/requestUserCard.dart';

import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final _firestore = Firestore.instance;
  List<String> friendList = [];
  List<dynamic> friends = [];
  List<dynamic> challengers = [];
  List<String> friendUserNames;
  List<String> friendUserIDs;
  List<String> challengerNames;
  List<String> challengerIDs;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Data userData = Provider.of<Data>(context);
    final AppThemeData theme = Provider.of<AppThemeData>(context);
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
                final users = snapshot.data.documents;
                friendUserNames = [];
                friendUserIDs = [];
                challengerIDs = [];
                challengerNames = [];

                for (var user in users) {
                  final String userID = user.data['userid'];
                  if (userData.currentUserID == userID) {
                    friends = user.data['friends'];
                    challengers = user.data['challenges'];
                  }
                }

                for (var user in users) {
                  final String userID = user.data['userid'];
                  final String userName = user.data['username'];
                  if (friends.contains(userID)) {
                    friendUserNames.add(userName);
                    friendUserIDs.add(userID);
                  }
                  if (challengers.contains(userID)) {
                    challengerNames.add(userName);
                    challengerIDs.add(userID);
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
                      SizedBox(
                        height: height * .04,
                      ),
                      Card(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Game Requests',
                            style: GoogleFonts.poppins(fontSize: width * .05,color:Colors.lime[600]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: challengerNames.length,
                          itemBuilder: (context, index) {
                            return RequestUserCard(
                              width: width,
                              height: height,
                              userName: challengerNames[index],
                              userID: challengerIDs[index],
                            );
                          },
                        ),
                      ),
                      Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Friends',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .05,
                                    color: Colors.lime[600])),
                          )),
                      Expanded(
                        flex: 4,
                        child: GridView.builder(
                          itemCount: friendUserNames.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: width * .3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return FriendUserCard(
                              width: width,
                              height: height,
                              userName: friendUserNames[index],
                              userID: friendUserIDs[index],
                            );
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
