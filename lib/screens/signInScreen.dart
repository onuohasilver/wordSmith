import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/utilities/components.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: userData.progressComplete,
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[700], Colors.green[400]],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('WORD SMITH',
                    textAlign: TextAlign.center, style: kTitleSelectText),
                Text('MULTIPLAYER',
                    style: TextStyle(
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.grey)])),
                Text('Sign-in',
                    style: TextStyle(
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.grey)])),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.lightBlueAccent.withOpacity(.3),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    onChanged: (email) => userData.updateEmail(email),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    maxLengthEnforced: true,
                    maxLength: 8,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.vpn_key),
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.lightBlueAccent.withOpacity(.3),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    onChanged: (password) => userData.updatePassword(password),
                  ),
                ),
                SlimButton(
                  label: 'Register Now',
                  onTap: () async {
                    userData.updateProgress();
                    print(userData.email);
                    print(userData.password);
                    try {
                      final loggedinUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: userData.email,
                              password: userData.password);
                      if (loggedinUser != null) {
                        userData.updateProgress();
                        Navigator.pushNamed(context, 'MultiLevelOne');
                      }
                    } catch (e) {}
                  },
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                )
              ],
            )),
      ),
    );
  }
}
