


import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:notes_app/services/auth.dart';
import 'package:notes_app/views/home.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool _isLoading = false;

  final AuthService _authService = new AuthService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();

  signMeUp() async{
    if(_formKey.currentState.validate()){
      setState((){
        _isLoading = true;
      });
      await _authService.signUpWithEmailAndPassword(_emailEditingController.text, _passwordEditingController.text).then((result){
        if (result == null){
          setState(() {
            _isLoading = false;
          });
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
                  SizedBox(height:15),
                  TextFormField(
                    controller: _emailEditingController,
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val) ? null : "Invalid Email";
                    },
                    style: TextStyle(fontSize: 18),
                    onChanged: (val) {
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                      controller: _passwordEditingController,
                      validator: (val){
                        return val.length > 6 ? null : "Too Small";
                      },
                      style: TextStyle(fontSize: 18),
                      obscureText: true,
                      onChanged: (val){
                      }
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      signMeUp().then(
                          Navigator.pushReplacementNamed(context, HomePage.id)
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: (){
                            widget.toggleView();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ]
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
