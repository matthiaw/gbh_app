// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:firebase_database/firebase_database.dart';

class News {
  String key;
  String image;
  String text;
  DateTime published;

  News(this.image, this.text, this.published);

  News.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        text = snapshot.value["text"],
        image = snapshot.value["image"],
        published = snapshot.value["published"];

  toJson() {
    return {
      "image": image,
      "text": text,
      "published": published,
    };
  }
}