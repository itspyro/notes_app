

import 'package:flutter/material.dart';
import 'package:notes_app/authentication/authenticate.dart';
import 'package:notes_app/modals/user.dart';
import 'package:notes_app/views/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  static String id = 'wrapper';

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<AppUser>(context);

    return user != null ? HomePage() : Authenticate();
  }
}