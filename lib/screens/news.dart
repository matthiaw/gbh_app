// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'package:gbh_app/models/news.dart';
import 'package:gbh_app/widgets/textwidgets.dart';
import 'package:gbh_app/utils/objectutils.dart';
import 'package:gbh_app/utils/databaseutil.dart';

/// News screen state class
class _NewsScreenState extends State<NewsScreen> {

  /// List of news
  List<News> _newsList;

  // Firebase database
  FirebaseDatabaseUtil databaseUtil;

  //initial state of widget
  @override
  void initState() {
    super.initState();

    databaseUtil = new FirebaseDatabaseUtil();

    _newsList = new List();

    databaseUtil.loadNews().then((List<News> newsList) {
      setState(() {
        _newsList = newsList;
      });
    });
  }

  // Create news widget drom dataitem in list
  Widget _buildNewsItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
            convertImage(_newsList[index].image),
            buildAlignedStyledText(context, _newsList[index].title, TextStyle( color: Theme.of(context).accentColor, fontSize: 18, fontWeight: FontWeight.bold)),
            buildAlignedText(context, _newsList[index].text),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

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

  // Convert image of news-article. If no image available set grey logo as default
  Widget convertImage(String base64image) {
    try {
       return convertBase64toImage(base64image, 150.0);
    } on FormatException catch(e) {
       return Image.asset('assets/logo.png', fit: BoxFit.scaleDown, width: 150, height: 150, colorBlendMode: BlendMode.saturation, color: Colors.white);
    }
  }

}

/// News widget class
class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewsScreenState();
}