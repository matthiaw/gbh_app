// Open Skies App (Gebetshaus Freiburg)
//
// Copyright (c) 2019, Matthias Wegner
//
// All rights reserved. Use of this source code is governed by GNU General Public License v3.0
//
// Original source from David Cheah, 2018
// - https://medium.com/flutterpub/flutter-how-to-do-user-login-with-firebase-a6af760b14d5
// - https://github.com/tattwei46/flutter_login_demo

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class for simple basic authentification
abstract class BaseAuth {
  // Method to sign into firebase
  Future<String> signIn(String email, String password);

  // Method to sign up in firebase
  Future<String> signUp(String email, String password);

  // Method to get current user
  Future<FirebaseUser> getCurrentUser();

  // Method to send e-mail verification
  Future<void> sendEmailVerification();

  // Method to sign out
  Future<void> signOut();

  // Method to check if e-mail is verified
  Future<bool> isEmailVerified();
}

/// Class for authenticate with firebase
class Auth implements BaseAuth {
  /// final instance of firebase-authentification
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// sign into firebase
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // sign up into firebase
  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  // get current user
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  // sign out
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // send e-mail verification
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  // check if e-mail after sign up is verified
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

}
