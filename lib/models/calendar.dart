// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:firebase_database/firebase_database.dart';

class Week {
  final List<Day> days;

  Week({this.days});

  factory Week.fromSnapshot(DataSnapshot snapshot) {

    List<dynamic> listS = snapshot.value;

    listS.forEach((value) =>
      print('V $value')
    );

    //var list = snapshot.value["days"] as List;
    List<Day> dayList = listS.map((i) => Day.fromJson(i)).toList();

    return Week(
        days: dayList
    );

  }

  toJson() {
    return {
      "days": days
    };
  }

  factory Week.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['days'] as List;
    print(list.runtimeType);
    List<Day> dayList = list.map((i) => Day.fromJson(i)).toList();

    return Week(
        days: dayList
    );
  }
}

class Day {
  final int id;
  final String nameOfDay;
  final List<Hour> hours;

  Day({this.id, this.nameOfDay, this.hours});

  factory Day.fromSnapshot(DataSnapshot snapshot) {
    var list = snapshot.value["hours"] as List;
    List<Hour> hourList = list.map((i) => Hour.fromJson(i)).toList();

    return Day(
      id: snapshot.value['id'],
        nameOfDay: snapshot.value['nameOfDay'],
        hours: hourList
    );

  }

  toJson() {
    return {
      "hours": hours
    };
  }

  factory Day.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['hours'] as List;
    print(list.runtimeType);
    List<Hour> hourList = list.map((i) => Hour.fromJson(i)).toList();


    return Day(
        id: parsedJson['id'],
        nameOfDay: parsedJson['name'],
        hours: hourList
    );
  }
}

class Hour {
  final int hourDuration;
  final int hourHour;
  final String hourTitle;
  final String hourSubtitle;
  String key;

  Hour({this.hourDuration, this.hourHour, this.hourTitle, this.hourSubtitle});

  Hour.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        hourDuration = snapshot.value["duration"],
        hourHour = snapshot.value["hour"],
        hourTitle = snapshot.value["title"],
        hourSubtitle = snapshot.value["subtitle"];

  toJson() {
    return {
      "duration": hourDuration,
      "hour": hourHour,
      "title": hourTitle,
      "subtitle": hourSubtitle,
    };
  }

  factory Hour.fromJson(Map<String, dynamic> parsedJson){
    return Hour(
        hourDuration:parsedJson['duration'],
        hourHour:parsedJson['hour'],
        hourTitle:parsedJson['title'],
        hourSubtitle:parsedJson['subtitle']
    );
  }
}