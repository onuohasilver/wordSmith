import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:wordsmith/components/displayComponents/inputFields/inputField.dart';
import 'package:wordsmith/components/displayComponents/logo.dart';
import 'package:wordsmith/userProvider/themeData.dart';
import 'package:wordsmith/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:wordsmith/userProvider/userData.dart';
import 'package:wordsmith/components/displayComponents/buttons/slimButtons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceInOut, parent: animationController));
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    animationController.repeat(reverse: true);
    final Data userData = Provider.of<Data>(context);
    final theme = Provider.of<AppThemeData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: userData.progressComplete,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, widget) {
              return Container(
                height: height,
                width: width,
                decoration: theme.background,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: WordCraftLogo(
                        height: height,
                        width: width,
                        animation: animation,
                      ),
                    ),
                    Text(
                      'MULTIPLAYER',
                      style: TextStyle(
                        color: Colors.white,
                        shadows: kTextShadow,
                      ),
                    ),
                    Text(
                      'Log In to Play with Friends!',
                      style: TextStyle(
                        color: Colors.white,
                        shadows: kTextShadow,
                      ),
                    ),
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
                        onChanged: (password) =>
                            userData.updatePassword(password),
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
                        SignUp(routeName: 'RegisterPage', label: 'Register')
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
