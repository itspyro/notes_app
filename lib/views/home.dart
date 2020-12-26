import 'package:flutter/material.dart';
import 'package:notes_app/services/auth.dart';

class HomePage extends StatefulWidget {

  static String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _authService = AuthService();

  signOut() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
