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

  final _formKey = new GlobalKey<FormState>();

  FirebaseDatabaseUtil databaseUtil;

  String _firstname;
  String _familyname;
  User _user;

  @override
  void initState() {
    super.initState();

    _formKey.currentState;

    databaseUtil = new FirebaseDatabaseUtil();

    widget.auth.getCurrentUser().then((user) {
        if (user != null) {
          String userId = user?.uid;
          databaseUtil.loadUser(userId).then((User user) {
            setState(() {
              _user = user;
            });
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return widget
    if (_user!=null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("User"),
          ),
          body: Center(
          child: new Form(
            key: _formKey,
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                _showFirstnameInput(_user.firstname),
                _showFamilynameInput(_user.familyname),
                _showButton(context),
              ],
            ),
          ))


      );
    } else {
      return Scaffold(
         appBar: AppBar(
         title: Text("User"),
      ),
      body: Center(
         child: Text('Keine Angabe'),
      ),
      );
    }
  }

  Widget _showFirstnameInput(String defaultName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        initialValue: defaultName,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Vorname',
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Vorname darf nicht leer sein' : null,
        onSaved: (value) => _firstname = value,
      ),
    );
  }

  Widget _showFamilynameInput(String defaultName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        initialValue: defaultName,
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Nachname',
            icon: new Icon(
              Icons.group,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Nachname darf nicht leer sein' : null,
        onSaved: (value) => _familyname = value,
      ),
    );
  }

  void _submit() async {

    // get current form
    final form = _formKey.currentState;

    // validate form
    if (form.validate()) {
      // save values from form
      form.save();

      // add guest-group if group is empty
      if (_user.group==null) {
        _user.group = "guest";
      } else if (_user.group=="") {
        _user.group = "guest";
      }

      // update user
      databaseUtil.updateUser(new User(_user.id, _firstname, _familyname, _user.group));
    }

  }

  Widget _showButton(BuildContext context) {

    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Theme.of(context).accentColor,
            child: new Text('Aktualisieren',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _submit,
          ),
        ));
  }

}

