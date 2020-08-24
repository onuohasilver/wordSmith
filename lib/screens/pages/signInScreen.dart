import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

import 'package:wordsmith/components/inputComponents/buttons/slimButtons.dart';
import 'package:wordsmith/components/inputComponents/textFields/inputField.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/core/utilities/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController boxAnimationController;
  Animation animation;
  Animation boxAnimation;
  Animation rboxAnimation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(curve: Curves.easeInBack, parent: animationController));
    boxAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    boxAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceIn, parent: boxAnimationController));
    rboxAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceIn, parent: boxAnimationController));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    boxAnimationController.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    animationController.repeat(reverse: true);

    boxAnimationController.forward();
    final Data userData = Provider.of<Data>(context);
    final theme = Provider.of<AppThemeData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: userData.progressComplete,
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
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
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          shadows: kTextShadow,
                        ),
                      ),
                      Text(
                        'Log In to Play with Friends!',
                        style: GoogleFonts.poppins(
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
                        obscure: false,
                        animation: rboxAnimation,
                        width: width,
                      ),
                      InputText(
                          userData: userData,
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          obscure: true,
                          animation: boxAnimation,
                          width: width,
                          onChanged: (password) =>
                              userData.updatePassword(password),
                          enforceLength: 8),
                      SlimButton(
                        label: 'Login',
                        onTap: () async {
                          userData.updateProgress();

                          try {
                            final loggedinUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: userData.email,
                                    password: userData.password);
                            if (loggedinUser != null) {
                              userData.updateProgress();
                              final loggedInUser = await _auth.currentUser();
                              String loggedInUserId = loggedInUser.uid;
                              userData.updateUserID(loggedInUserId);
                              firestore
                                  .collection('users')
                                  .document(loggedInUserId)
                                  .get()
                                  .then((value) => userData
                                      .updateUserName(value['username']));
                              firestore
                                  .collection('users')
                                  .document(loggedInUser.uid)
                                  .setData(
                                {'online': true},
                                merge: true,
                              );
                              Navigator.pushReplacementNamed(
                                  context, 'PlayerScreen');
                            }
                          } catch (e) {
                            print(e.toString());
                          }
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
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
      ),
    );
  }
}
