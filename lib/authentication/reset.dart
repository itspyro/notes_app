

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:notes_app/authentication/resetmsg.dart';
import 'package:notes_app/services/auth.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {

  bool _isLoading = false;

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailEditingController = new TextEditingController();

  reset() async {
    if(_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _authService.resetPass(_emailEditingController.text).then((result){
        if(result == null){
          _isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical:20, horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/logo.jpg'),
                        height: 175,
                      ),
                    ),
                    SizedBox(height:20),
                    TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val) ? null : "Invalid Email";
                      },
                      controller: _emailEditingController,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        reset().then(
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ResetMessage()))
                        );



                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xff007ef4),
                                const Color(0xff2a75bc),
                              ]
                          ),
                        ),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
