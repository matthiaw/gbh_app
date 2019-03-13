// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0

/// Small class to define screens with icon and navigation path which are accessible from homescreen
class Screen {

  String userId;

  // title of screen. Is used as bootom text under icon
  String title;

  // icon of screen. Must be full filename in assets
  String icon;

  // Navigation path of screen
  String path;

  // Constructor of screen.
  Screen(this.title, this.icon, this.path, this.userId);

}