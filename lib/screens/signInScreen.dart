import 'package:flutter/material.dart';
import 'package:wordsmith/components/displayComponents/inputFields/inputField.dart';
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
            decoration: userData.theme,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('WORD SMITH',
                    textAlign: TextAlign.center, style: kTitleSelectText),
                Text('MULTIPLAYER',
                    style:
                        TextStyle(color: Colors.white, shadows: kTextShadow)),
                Text('Log In to Play with Friends!',
                    style:
                        TextStyle(color: Colors.white, shadows: kTextShadow)),
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
                    hintText: 'Password',
                    keyboardType: TextInputType.text,
                    obscure: true,
                    onChanged: (password) => userData.updatePassword(password),
                    enforceLength: 8),
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
                        Navigator.pushReplacementNamed(
                            context, 'PlayerScreen');
                      }
                    } catch (e) {}
                  },
                  color: Colors.white.withOpacity(.1),
                  textColor: Colors.white,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Need a new account?',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    SignUp(routeName: 'RegisterPage',label:'Register')
                  ],
                )
              ],
            )),
      ),
    );
  }
}
