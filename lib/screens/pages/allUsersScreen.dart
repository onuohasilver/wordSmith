import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:wordsmith/components/cardComponents/opponentUserCard.dart';
import 'package:wordsmith/core/utilities/constants.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';

class AllUsersScreen extends StatefulWidget {
  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final _firestore = Firestore.instance;
  List<String> friendList = [];
  List<dynamic> friends = [];
  List<String> userNames;
  List<String> userIDs;

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
                userNames = [];
                userIDs = [];
                for (var user in users) {
                  final String userID = user.data['userid'];
                  final String userName = user.data['username'];

                  userNames.add(userName);
                  userIDs.add(userID);
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
                          itemCount: userNames.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: width * .3,
                                  
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return OpponentUserCard(
                              width: width,
                              height: height,
                              userName: userNames[index],
                              userID: userIDs[index],
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
