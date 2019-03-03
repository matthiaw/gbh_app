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

/// Stateless widget to show link to deeper-podcasts
class DeeperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deeper"),
      ),
      body: Center(
        // load future value of application properties - unused at the moment
        child: FutureBuilder(
          future: loadAppProperties(context),
          // build in dependency of conection-state loading item or data widget
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              // display circular indicator of loading
              return CircularProgressIndicator(backgroundColor: Colors.blue);
            } else {
              // decode json-data of application properties from loaded snapshot
              Map<String, dynamic> properties = json.decode(snapshot.data);
              // create deeper-icon
              return new Material(
                  color: Colors.transparent,
                  child: Ink.image(
                      image: AssetImage('assets/soundcloud.jpg'),
                      fit: BoxFit.scaleDown,
                      width: 200,
                      height: 200,
                      child: InkWell(
                        onTap: () {
                          _launchURL();
                        }, //onTap
                      )));
              // Navigate back to the first screen by popping the current route
              // off the stack
              // Navigator.pop(context);
              // child: Text('Zurück! '+ properties['param1']),
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
    const url = 'https://soundcloud.com/deeper-gbh-freiburg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Load application-properties
  Future loadAppProperties(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/app.config');
    //return new Future.delayed(
    //    const Duration(seconds: 5), () => print('waiting'));
  }

}
