// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';
import 'dart:async' show Future;
import 'package:firebase_database/firebase_database.dart';
import 'package:gbh_app/models/news.dart';

class _NewsScreenState extends State<NewsScreen> {

  List<News> _newsList;

  Query _newsQuery;

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();

    _newsList = new List();

    _newsQuery = _database
        .reference()
        .child('news')
        .orderByChild('published')
        .limitToFirst(10);

    _newsQuery.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      News n = News.fromSnapshot(event.snapshot);
      print(n.text);
      _newsList.add(n);
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
              convert(_newsList[index].image),
              Text(_newsList[index].text, style: TextStyle(color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    print(_newsList.length);

    if (_newsList.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Nachrichten"),
        ),
        body: Center(
          child: new ListView.builder(
          shrinkWrap: true,
          itemCount: _newsList.length,
          itemBuilder: _buildNewsItem,
          ),
          ),

    );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Nachrichten"),
        ),
        body: Center(
          child: Text('Keine Nachrichten',
        ),
        ),
      );
    }
  }

  Image convert(String base64image) {
    try {
       const BASE64 = const Base64Codec();
       Uint8List bytes = BASE64.decode(base64image);
       return new Image.memory(bytes);
    } on FormatException catch(e) {
       return Image.asset('assets/logo.png');
    }
  }

}

class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewsScreenState();
}