// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'package:gbh_app/models/hour.dart';
import 'package:gbh_app/widgets/textwidgets.dart';
import 'package:gbh_app/utils/databaseutil.dart';

class _CalendarScreenState extends State<CalendarScreen> {

  String _dropdownValue = 'Woche';

  List<Hour> _hourList;

  List<Hour> _selectionList;

  // Firebase database
  FirebaseDatabaseUtil databaseUtil;

  //initial state of widget
  @override
  void initState() {
    super.initState();

    databaseUtil = new FirebaseDatabaseUtil();

    _hourList = new List();
    _selectionList = new List();

    databaseUtil.loadHours().then((List<Hour> hourList) {
      setState(() {
        _hourList = hourList;
        _selectionList = hourList;
      });
    });
  }

  _onSelection() {
    _selectionList = new List();
      for(var item in _hourList) {
           if (_dropdownValue=="Woche") {
              _selectionList.add(item);
           } else if (item.nameOfDay==_dropdownValue) {
             _selectionList.add(item);
           }
      }
  }

  Widget _buildHourItem(BuildContext context, int index) {
    int starttime = _selectionList[index].time;
    int endtime = _selectionList[index].duration + starttime;
    String timeframe = "";
    if (_dropdownValue=="Woche") {
      timeframe = _selectionList[index].nameOfDay + " ${starttime}:00 - ${endtime}:00 Uhr";
    } else {
      timeframe = "${starttime}:00 - ${endtime}:00 Uhr";
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              buildAlignedStyledText(context, timeframe, TextStyle( color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal)),
              buildAlignedStyledText(context, _selectionList[index].title, TextStyle( color: Theme.of(context).accentColor, fontSize: 28, fontWeight: FontWeight.bold)),
              buildAlignedStyledText(context, _selectionList[index].subtitle, TextStyle( color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (_hourList.length > 0) {
      var i = _selectionList.length;
      return Scaffold(
        appBar: AppBar(
          title: Text("Gebetsstunden"),
          actions: <Widget>[
        new DropdownButton<String>(
          value: _dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              _dropdownValue = newValue;
              _onSelection();
            });
          },
          items: <String>['Woche', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag', 'Sonntag']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
          ],
        ),
        body: Center(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: _selectionList.length,
            itemBuilder: _buildHourItem,
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