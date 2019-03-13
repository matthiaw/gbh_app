// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0
//
// Original source from David Cheah, 2018
// - https://medium.com/flutterpub/flutter-how-to-do-user-login-with-firebase-a6af760b14d5
// - https://github.com/tattwei46/flutter_login_demo

import 'package:flutter/material.dart';
import 'package:gbh_app/screens/login.dart';
import 'package:gbh_app/services/authentication.dart';
import 'package:gbh_app/screens/home.dart';
import 'package:gbh_app/models/screen.dart';

class RootScreen extends StatefulWidget {
  List<Screen> screenPages = new List<Screen>();

  RootScreen({this.auth}) {
    screenPages.add(new Screen('Nachrichten', 'news.png', '/news', null));
    screenPages.add(new Screen('Deeper', 'deeper.png', '/deeper', null));
    screenPages.add(new Screen('Soundcloud', 'soundcloud.png', '/soundcloud', null));
    screenPages.add(new Screen('YouTube', 'youtube.png', '/youtube', null));
    screenPages.add(new Screen('Produkte', 'products.png', '/products', null));
    screenPages.add(new Screen('Gebetstunden', 'logo.png', '/calendar', null));
  }

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState(screenPages);
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootScreen> {
  _RootPageState(this.screens);

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  final List<Screen> screens;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpScreen(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomeScreen(
            title: 'Gebetshaus Freiburg',
            screens: screens,
            userId: _userId,
            auth: widget.auth,
            onSignedOut: _onSignedOut,
          );
        } else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}
