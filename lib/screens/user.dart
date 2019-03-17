// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:gbh_app/services/authentication.dart';
import 'dart:async' show Future;
import 'package:url_launcher/url_launcher.dart';
import 'package:gbh_app/models/user.dart';

class UserScreen extends StatefulWidget {

  UserScreen({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _UserScreenState();

}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _UserScreenState extends State<UserScreen> {
  _UserScreenState();

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          print("Logged in: "+_userId);
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;

        //User u = widget.auth.getUser(_userId);

        //if (u==null) {
       //   widget.auth.addUser(_userId);
        //}

        //print(u);

      });
    });
    //print("Logged in: "+_userId);
  }

  @override
  Widget build(BuildContext context) {
    // return widget
    return Scaffold(
        appBar: AppBar(
          title: Text("User"),
        ),
        body: Center(
        )
    );
  }
}

