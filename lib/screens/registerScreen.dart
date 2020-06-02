import 'package:flutter/material.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
import 'package:wordsmith/components/displayComponents/inputFields/inputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Data>(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: userData.progressComplete,
        child: Container(
            decoration: userData.theme,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('WORD SMITH',
                    textAlign: TextAlign.center, style: kTitleSelectText),
                Text('MULTIPLAYER',
                    style: TextStyle(
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.grey)])),
                Text('Register',
                    style: TextStyle(
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.grey)])),
                SizedBox(height: 30),
                InputText(
                    userData: userData,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    enforceLength: null,
                    onChanged: (email) => userData.updateEmail(email),
                    obscure: false),
                InputText(
                    userData: userData,
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                    enforceLength: null,
                    onChanged: (userName) => userData.updateUserName(userName),
                    obscure: false),
                InputText(
                    userData: userData,
                    hintText: 'Password',
                    keyboardType: TextInputType.text,
                    obscure: true,
                    onChanged: (password) => userData.updatePassword(password),
                    enforceLength: 8),
                SlimButton(
                  label: 'Register Now',
                  useWidget: false,
                  color: Colors.white.withOpacity(.1),
                  onTap: () async {
                    userData.updateProgress();
                    try {
                      final loggedinUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: userData.email,
                              password: userData.password);
                      if (loggedinUser != null) {
                        userData.updateProgress();
                        final currentUser = await _auth.currentUser();

                        _firestore
                            .collection('users')
                            .document(currentUser.uid)
                            .setData({
                          'userid': currentUser.uid,
                          'username': userData.userName,
                          'friends': ['computer']
                        });
                        Navigator.pushReplacementNamed(
                            context, 'PlayerScreen');
                      }
                    } catch (e) {}
                  },
                  textColor: Colors.white,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    SignUp(label:'Sign In',routeName: 'SignInPage',),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

