

import 'package:flutter/material.dart';
import 'package:notes_app/authentication/register.dart';
import 'package:notes_app/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {

  static String id = 'auth_screen';

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
