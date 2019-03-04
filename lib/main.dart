// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

import 'package:flutter/material.dart';
import 'package:gbh_app/screens/news.dart';
import 'package:gbh_app/screens/root.dart';
import 'package:gbh_app/screens/deeper.dart';
import 'package:gbh_app/services/authentication.dart';
import 'package:gbh_app/screens/soundcloud.dart';
import 'package:gbh_app/screens/youtube.dart';
import 'package:gbh_app/models/theme.dart';
import 'package:gbh_app/screens/products.dart';

/// Main if the application
void main() => runApp(OpenSkiesApp());

/// Main class of the app as stateless widget
class OpenSkiesApp extends StatelessWidget {

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {

    // returns widget
    return MaterialApp(
      // title of widget
      title: 'Gebetshaus Freiburg',
      // theme of widget set to default application theme
      theme: AppThemeData,
      // Start the app with the "/" named route. In our case, the app will start
      // on the FirstScreen Widget
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the RootScreen Widget
        '/': (context) => RootScreen(auth: new Auth()),
        // When we navigate to the "/news" build NewsScreen Widget
        '/news': (context) => NewsScreen(),
        // When we navigate to the "/deeper" build DeeperScreen Widget
        '/deeper': (context) => DeeperScreen(),
        // When we navigate to the "/soundcloud" build SoundcloudScreen Widget
        '/soundcloud': (context) => SoundcloudScreen(),
        // When we navigate to the "/youtube" build YoutTubeScreen Widget
        '/youtube': (context) => YouTubeScreen(),
        // When we navigate to the "/products" build ProductScreen Widget
        '/products': (context) => ProductScreen(),
      },
    );
  }

}



