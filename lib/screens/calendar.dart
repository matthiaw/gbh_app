// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:gbh_app/models/calendar.dart';
import 'package:gbh_app/widgets/textwidgets.dart';
import 'package:gbh_app/utils/objectutils.dart';

/// News screen state class
class _CalendarScreenState extends State<CalendarScreen> {

  Week week;

  // Query of firebase realtime database (not firestore)
  Query _newsQuery;

  // Firebase database
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  //initial state of widget
  @override
  void initState() {
    super.initState();

    _newsQuery = _database
        .reference()
        .child('week')
        .limitToFirst(1);

    _newsQuery.onChildAdded.listen(_onEntryAdded);
  }

  /// Create and add News-Class to list from json-data-snapshot
  _onEntryAdded(Event event) {
    setState(() {
      week = Week.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {

    if (week==1) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Gebetstunden"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    buildAlignedStyledText(context, week.days.elementAt(1).nameOfDay, TextStyle( color: Theme.of(context).accentColor, fontSize: 18, fontWeight: FontWeight.bold)),
                    // buildAlignedText(context, _newsList[index].text),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Gebetstunden"),
        ),
        body: Center(
          child: Text('Keine Angabe',
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