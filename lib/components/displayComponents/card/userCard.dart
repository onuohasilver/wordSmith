import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.width,
    @required this.userName,
  }) : super(key: key);

  final double width;
  final String userName;

  @override
  Widget build(BuildContext context) {
     final Data userData = Provider.of<Data>(context);
    return Material(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: width * .08,
                ),
                backgroundColor: Colors.lime[600],
                maxRadius: width * .07,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  userName,
                  style: GoogleFonts.poppins(color: Colors.lime[600]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              elevation: 3,
              onPressed: () {

              },
              child: Text(
                'Challenge',
                style: GoogleFonts.poppins(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
