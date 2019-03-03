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

//    print(_database.reference().root());

    _newsQuery = _database
        .reference()
        .child("news");

    _newsQuery.onChildAdded.listen(_onEntryAdded);
  }

  _onEntryAdded(Event event) {
    setState(() {
      _newsList.add(News.fromSnapshot(event.snapshot));
    });
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
          itemBuilder: (BuildContext context, int index) {
            String id = _newsList[index].key;
            String text = _newsList[index].text;
            String bimg = _newsList[index].image;
            Image img = convert(bimg);
            child: ListTile(
              leading: img,
              title: new Text(text),
            );
          }
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
    const BASE64 = const Base64Codec();
    Uint8List bytes = BASE64.decode(base64image);
    return new Image.memory(bytes);
  }

}

class NewsScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _NewsScreenState();


}