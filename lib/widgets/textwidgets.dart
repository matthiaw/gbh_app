import 'package:flutter/material.dart';
import 'dart:convert';

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
