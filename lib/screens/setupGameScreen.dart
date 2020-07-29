// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:wordsmith/screens/multiPlayerLevels/multiLevelOne.dart';
// import 'package:wordsmith/userProvider/userData.dart';
// import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
// import 'package:wordsmith/components/displayComponents/inputFields/inputField.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:wordsmith/utilities/constants.dart';
// import 'dart:math';

// class SetupGameScreen extends StatefulWidget {
//   final String opponentName;
//   final String opponentID;
//   final String currentUserName;
//   final String currentUserID;

//   SetupGameScreen({
//     this.opponentName,
//     this.opponentID,
//     this.currentUserName,
//     this.currentUserID,
//   });
//   @override
//   _SetupGameScreenState createState() => _SetupGameScreenState();
// }

// bool startSpin = false;
// bool activateGame = false;
// int randomIndex = Random().nextInt(9);
// String gameID;
// getGameID(String current,String challenger){
//   return '${current.substring(4,10)}${challenger.substring(4,10)}';
// }


// class _SetupGameScreenState extends State<SetupGameScreen> {
//   final _firestore = Firestore.instance;
  

//   @override
//   Widget build(BuildContext context) {
//     final userData = Provider.of<Data>(context);
//     return Scaffold(
//       body: Container(
//         decoration: kPurpleScreenDecoration,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('😎😺',
//                 style: TextStyle(
//                     fontSize: 40,
//                     color: Colors.lightBlueAccent.withOpacity(.1))),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(18.0, 3.0, 18.0, 3.0),
//               child: InputText(
//                 userData: userData,
//                 hintText: 'Enter a Game ID',
//                 obscure: false,
//                 enforceLength: 8,
//                 keyboardType: TextInputType.text,
//                 onChanged: (String gameID) {
//                   userData.updateGameID('gameID');
//                 },
//               ),
//             ),
            

//             Container(
//               child: SlimButton(
//                 label: 'Create Game',
//                 useWidget: false,
//                 color: Colors.lightBlueAccent.shade700,
//                 textColor: Colors.white,
//                 onTap: () {
//                   setState(() {
//                     startSpin = true;
//                   });



//                   _firestore
//                       .collection('entry')
//                       .document(userData.opponentGameID)
//                       .setData({
//                     'senderID': widget.opponentID,
//                     'text': [],
//                     'gameID': userData.opponentGameID,
//                     'randomIndex': randomIndex,
//                     'validate': []
//                   }, merge: true);
//                   _firestore
//                       .collection('entry')
//                       .document(userData.challengerGameID)
//                       .setData({
//                     'senderID': widget.currentUserID,
//                     'text': [],
//                     'gameID': userData.challengerGameID,
//                     'randomIndex': randomIndex,
//                     'validate': []
//                   }, merge: true);
//                 },
//               ),
//             ),
//             SizedBox(
//                 child: SpinKitThreeBounce(
//                     color:
//                         startSpin ? Colors.lightBlueAccent : Colors.transparent,
//                     size: 50)),
//             SizedBox(
//               height: 40,
//             ),
//             Text(
//               'Game ID should consist of eight characters',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white.withOpacity(.5),
//               ),
//             ),
//             Container(
//                 child: startSpin
//                     ? ActiveGameStream(
//                         firestore: _firestore,
//                         userData: userData,
//                         opponentID: widget.opponentID,
//                         opponentName: widget.opponentName,
//                         currentUserID: widget.currentUserID,
//                         currentUserName: widget.currentUserName,
//                       )
//                     : Text(''))
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     startSpin = false;
//     activateGame = false;

//     super.dispose();
//   }
// }

// class ActiveGameStream extends StatelessWidget {
//   const ActiveGameStream({
//     Key key,
//     @required Firestore firestore,
//     @required this.userData,
//     @required this.opponentName,
//     @required this.opponentID,
//     @required this.currentUserName,
//     @required this.currentUserID,
//   })  : _firestore = firestore,
//         super(key: key);

//   final Firestore _firestore;
//   final Data userData;
//   final String opponentName;
//   final String opponentID;
//   final String currentUserName;
//   final String currentUserID;

//   @override
//   Widget build(BuildContext context) {
//     return StreamListenableBuilder<DocumentSnapshot>(
//       stream:
//           _firestore.collection('activeGames').document('active').snapshots(),
//       listener: (value) {
//         if (value['active'].contains(userData.opponentGameID)) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) {
//               return MultiLevelOne(
//                   opponentName: opponentName,
//                   opponentID: opponentID,
//                   currentUserName: currentUserName,
//                   currentUserID: currentUserID,
//                   opponentGameID: userData.opponentGameID,
//                   currentUserGameID: userData.challengerGameID,
//                   randomIndex: randomIndex);
//             }),
//           );
//         }
//       },
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final entry = snapshot.data;
//           final activeGameList = entry['active'];

//           if (activeGameList.contains(userData.opponentGameID)) {
//             print(activeGameList);

//             activateGame = true;
//           } else {
//             activateGame = false;
//           }
//         }

//         return Text('$activateGame, ${userData.opponentGameID}');
//       },
//     );
//   }
// }

// //thank you stackoverflow
// typedef StreamListener<T> = void Function(T value);

// class StreamListenableBuilder<T> extends StreamBuilder<T> {
//   final StreamListener<T> listener;

//   const StreamListenableBuilder({
//     Key key,
//     T initialData,
//     Stream<T> stream,
//     @required this.listener,
//     @required AsyncWidgetBuilder<T> builder,
//   }) : super(
//             key: key,
//             initialData: initialData,
//             stream: stream,
//             builder: builder);

//   @override
//   AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
//     listener(data);
//     return super.afterData(current, data);
//   }
// }
