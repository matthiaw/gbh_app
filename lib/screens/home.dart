// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'package:gbh_app/models/screen.dart';
import 'package:gbh_app/services/authentication.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title,  this.screens, this.auth, this.userId, this.onSignedOut}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final  List<Screen> screens;
  final String title;

  @override
  _HomePageState createState() => _HomePageState(screens, userId);

}

class _HomePageState extends State<HomeScreen> {

  String userId;

  _HomePageState(this.screens, this.userId);

  final List<Screen> screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 14.0, color: Colors.white)),
              onPressed: _signOut)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 3,
            // Generate Widgets that display their index in the List
          children: List.generate(screens.length, (index) {
            Screen screen = screens[index];
            return createStructuredGridCell(screen);
          }),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  } //build

  Card createStructuredGridCell(Screen screenItem) {
    var iconSize = 60.0;
    return new Card(
        elevation: 5.0,
        color: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
          new Material(
                  color: Theme.of(context).backgroundColor,
                  child: Ink.image(
                      image: AssetImage('assets/'+screenItem.icon+''),
                      fit: BoxFit.scaleDown, width: iconSize, height: iconSize,
                      child: InkWell (
                          onTap: () {
                            Navigator.pushNamed(context, screenItem.path, arguments: userId);
                          }, //onTap
                      )
                  )
              ),
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      screenItem.title,
                      style: TextStyle(color: Colors.white)
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    _checkEmailVerification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail(){
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

} //HomePageState
