// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String firstname;
  String familyname;
  String group;

  User(this.id, this.firstname, this.familyname, this.group);

  User.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        firstname = snapshot.value["firstname"],
        familyname = snapshot.value["familyname"],
        group = snapshot.value["group"];

  toJson() {
    return {
      "firstname": firstname,
      "familyname": familyname,
      "group": group,
    };
  }
}