// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'package:gbh_app/services/authentication.dart';
import 'package:gbh_app/models/user.dart';
import 'package:gbh_app/utils/databaseutil.dart';

class UserScreen extends StatefulWidget {

  UserScreen({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _UserScreenState();

}

class _UserScreenState extends State<UserScreen> {
  _UserScreenState();

  FirebaseDatabaseUtil databaseUtil;

  String _userId = "";

  @override
  void initState() {
    super.initState();

    databaseUtil = new FirebaseDatabaseUtil();

    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          //print("User logged in: "+_userId);
          databaseUtil.loadUser(_userId).then((User user) {
            print(user.toJson());
          });
        }

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

