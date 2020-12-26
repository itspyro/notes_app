

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:notes_app/authentication/reset.dart';
import 'package:notes_app/services/auth.dart';
import 'package:notes_app/views/home.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn ({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool _isLoading = false;

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();

  signMeIn() async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      await _authService.signInWithEmailAndPassword(_emailEditingController.text, _passwordEditingController.text).then((result){
        print(result);
        if (result == null){
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
                  TextFormField(
                    validator: (val){
                      return val.length > 6 ? null : "Too Small";
                    },
                    controller: _passwordEditingController,
                    style: TextStyle(fontSize: 18),
                    obscureText: true,
                  ),
                  SizedBox(height: 5),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reset()
                        ),
                        );

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text("Forgot Password?", style: TextStyle(fontSize: 18, decoration: TextDecoration.underline),),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: (){
                      signMeIn().then(
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
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: (){
                            widget.toggleView();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: Text(
                              "Register Now",
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
