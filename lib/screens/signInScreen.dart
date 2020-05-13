import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Data>(context);
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
                Text('Log In to Play!',
                    style: TextStyle(
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.grey)])),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35.0,8.0,35.0,8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        
                        hintText: 'Email',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.lightBlueAccent.withOpacity(.3),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    onChanged: (email) => userData.updateEmail(email),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35.0,8.0,35.0,8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    maxLengthEnforced: true,
                    maxLength: 8,
                    decoration: InputDecoration(
                        
                        hintText: 'Password',
                        hintStyle: TextStyle(),
                        filled: true,
                        fillColor: Colors.lightBlueAccent.withOpacity(.3),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    onChanged: (password) => userData.updatePassword(password),
                  ),
                ),
                SlimButton(
                  label: 'Login',
                  useWidget: false,
                  onTap: () async {
                    userData.updateProgress();
                    
                    try {
                      final loggedinUser =
                          await _auth.signInWithEmailAndPassword(
                              email: userData.email,
                              password: userData.password);
                      if (loggedinUser != null) {
                        userData.updateProgress();
                        Navigator.pushNamed(context, 'ChooseOpponent');
                      }
                    } catch (e) {}
                  },
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                ),
                SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Need a new account?',style: TextStyle(fontWeight:FontWeight.w600,color: Colors.white),),
                    SizedBox(width:10),
                    GestureDetector(
                      onTap:()=>Navigator.pushNamed(context, 'RegisterPage'),
                                          child: Text('REGISTER',
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 20,
                              color: Colors.lightBlueAccent,
                              shadows: [Shadow(color:Colors.black38,blurRadius:3)],
                              decoration: TextDecoration.underline
                            )),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }


}
