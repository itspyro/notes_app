


import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ResetMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TypewriterAnimatedTextKit(
            text: ["Check Email For Reset Link"],
            textStyle: TextStyle(fontSize: 22, color: Colors.black),
            speed: Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }
}