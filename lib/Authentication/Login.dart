import 'package:coffeco/Services/auth.dart';
import 'package:coffeco/constants/sign_in_buttons.dart';
import 'package:coffeco/constants/widgets.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading=false;
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error="";
  AuthServices auth=AuthServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bodyBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("What's your email ?",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: inputDecoration.copyWith(labelText: "Email"),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (value) => value.isEmpty ? "Enter email" : null,
                    ),
                    SizedBox(height:20.0),
                    Text("What's your password",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: inputDecoration.copyWith(labelText: "Password"),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (value) => value.length<5 ? "Password must be greater than 5 character" : null,
                    ),
                    SizedBox(height: 20,),
                    _loading?Loading():signInButton(
                      text: "Sign Up",
                      color: Colors.black38,
                      textcolor: Colors.white,
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          setState(() {
                            _loading=true;
                          });
                          dynamic result=await auth.logInwithEmail(email, password);
                          if(result!=null)
                            Navigator.pop(context);
                          else
                          {
                            setState(() {
                              error=AuthServices().errors;
                              _loading=false;
                            });
                          }

                        }

                      },
                      borderRadius: 20,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        error,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
