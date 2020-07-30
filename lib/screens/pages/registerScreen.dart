import 'package:flutter/material.dart';
import 'package:wordsmith/components/inputComponents/buttons/slimButtons.dart';
import 'package:wordsmith/components/inputComponents/textFields/inputField.dart';
import 'package:wordsmith/core/logo.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/themeData.dart';
import 'package:wordsmith/handlers/stateHandlers/providerHandlers/userData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Firestore _firestore = Firestore.instance;
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
      duration: Duration(seconds: 3),
    );
    boxAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceIn, parent: boxAnimationController));
    rboxAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.bounceIn, parent: boxAnimationController));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Data userData = Provider.of<Data>(context);
    final AppThemeData theme = Provider.of<AppThemeData>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    boxAnimationController.forward();
    animationController.repeat(reverse: true);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: userData.progressComplete,
        child: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, widget) {
              return Container(
                  decoration: theme.background,
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      WordCraftLogo(
                        width: width,
                        height: height,
                        animation: animation,
                      ),
                      Text('MULTIPLAYER',
                          style: TextStyle(color: Colors.white, shadows: [
                            Shadow(blurRadius: 3, color: Colors.grey)
                          ])),
                      Text('Register',
                          style: TextStyle(color: Colors.white, shadows: [
                            Shadow(blurRadius: 3, color: Colors.grey)
                          ])),
                      SizedBox(height: 30),
                      InputText(
                          userData: userData,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          enforceLength: null,
                          onChanged: (email) => userData.updateEmail(email),
                          obscure: false,
                          animation: rboxAnimation,
                          width: width),
                      InputText(
                          userData: userData,
                          hintText: 'Username',
                          keyboardType: TextInputType.text,
                          enforceLength: null,
                          onChanged: (userName) =>
                              userData.updateUserName(userName),
                          obscure: false,
                          animation: boxAnimation,
                          width: width),
                      InputText(
                          userData: userData,
                          hintText: 'Password',
                          keyboardType: TextInputType.text,
                          obscure: true,
                          onChanged: (password) =>
                              userData.updatePassword(password),
                          enforceLength: 8,
                          animation: rboxAnimation,
                          width: width),
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
                              final loggedInUser = await _auth.currentUser();
                              String loggedInUserId = loggedInUser.uid;
                              userData.updateUserID(loggedInUserId);
                              userData.updateProgress();

                              _firestore
                                  .collection('users')
                                  .document(loggedInUser.uid)
                                  .setData({
                                'userid': loggedInUser.uid,
                                'username': userData.userName,
                                'friends': ['computer'],
                                'challenges': [''],
                                'activeGames': [''],
                                'activeChallenges':[],
                                'email': userData.email,
                                'password': userData.password,
                                'online':true
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
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          SignUp(
                            label: 'Sign In',
                            routeName: 'SignInPage',
                          ),
                        ],
                      )
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
