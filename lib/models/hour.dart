// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:firebase_database/firebase_database.dart';

class Hour {
  String key;
  int duration;
  int time;
  String title;
  String subtitle;
  String nameOfDay;
  int idOfDay;

  Hour(this.title, this.subtitle, this.duration, this.time, this.nameOfDay, this.idOfDay);

  Hour.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        title = snapshot.value["title"],
        subtitle = snapshot.value["subtitle"],
        duration = snapshot.value["duration"],
        time = snapshot.value["hour"],
        nameOfDay = snapshot.value["nameOfDay"],
        idOfDay = snapshot.value["idOfDay"];

  toJson() {
    return {
      "duration": duration,
      "time": time,
      "title": title,
      "subtitle": subtitle,
      "nameOfDay": nameOfDay,
      "idOfDay": idOfDay,
    };
  }
}