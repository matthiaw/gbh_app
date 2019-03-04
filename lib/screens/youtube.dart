// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:async' show Future;
import 'package:url_launcher/url_launcher.dart';

/// Stateless widget to show link to soundcloud-live-records
class YouTubeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return widget
    return Scaffold(
      appBar: AppBar(
        title: Text("YouTube"),
      ),
      body: Center(
        // load future value of application properties - unused at the moment
        child: FutureBuilder(
          // loading ...
          future: loadAppProperties(context),
          // build in dependency of conection-state loading item or data widget
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              // display circular indicator of loading
              return CircularProgressIndicator(backgroundColor: Colors.blue);
            } else {
              // decode json-data of application properties from loaded snapshot
              Map<String, dynamic> properties = json.decode(snapshot.data);
              // create soundcloud-icon
              return new Material(
                  color: Colors.transparent,
                  child: Ink.image(
                      image: AssetImage('assets/youtube.png'),
                      fit: BoxFit.scaleDown,
                      width: 200,
                      height: 200,
                      child: InkWell(
                        onTap: () {
                          // active link to soundcloud
                          _launchURL();
                        }, //onTap
                      )));
            }
          },
        ),
      ),
      // set background color
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  // launch url
  _launchURL() async {
    const url = 'https://www.youtube.com/channel/UCGQxGQfnA4QnG6zhvol4eew';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Load application-properties
  Future loadAppProperties(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/app.config');
  }
}
