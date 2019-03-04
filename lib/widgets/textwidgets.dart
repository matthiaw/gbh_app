// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';

Widget buildAlignedText(BuildContext context, String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(text, style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
}

Widget buildAlignedStyledText(
    BuildContext context, String text, TextStyle style) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(text, style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
}
