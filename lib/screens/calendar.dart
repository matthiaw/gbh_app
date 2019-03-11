// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:gbh_app/models/hour.dart';
import 'package:gbh_app/widgets/textwidgets.dart';
import 'package:gbh_app/utils/objectutils.dart';

/// News screen state class
class _CalendarScreenState extends State<CalendarScreen> {

  List<Hour> _hourList;

  // Query of firebase realtime database (not firestore)
  Query _hourQuery;

  // Firebase database
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  //initial state of widget
  @override
  void initState() {
    super.initState();

    _hourList = new List();

    _hourQuery = _database
        .reference()
        .child('hours');

    _hourQuery.onChildAdded.listen(_onEntryAdded);
  }

  /// Create and add News-Class to list from json-data-snapshot
  _onEntryAdded(Event event) {
    setState(() {
      Hour h = Hour.fromSnapshot(event.snapshot);
      _hourList.add(h);
    });
  }

  Widget _buildNewsItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              buildAlignedStyledText(context, _hourList[index].title, TextStyle( color: Theme.of(context).accentColor, fontSize: 18, fontWeight: FontWeight.bold)),
             ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (_hourList.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Gebetsstunden"),
        ),
        body: Center(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: _hourList.length,
            itemBuilder: _buildNewsItem,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Gebetsstunden"),
        ),
        body: Center(
          child: Text('Keine Gebetsstunden',
          ),
        ),
      );
    }
  }

}

/// Calendar widget class
class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalendarScreenState();
}