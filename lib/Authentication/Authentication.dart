import 'package:coffeco/Authentication/Login.dart';
import 'package:coffeco/Services/auth.dart';
import 'package:coffeco/constants/sign_in_buttons.dart';
import 'package:coffeco/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Signup.dart';


class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  AuthServices auth=AuthServices();
  bool loading=false;
  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        loading=true;
      });
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
      setState(() {
        loading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),
                  Image.asset("assets/cafe-logo.png"),

                  Text(
                    "Coffeeco",
                    style: TextStyle(
                        color: Color.fromRGBO(183, 110, 49, 1), fontSize: 40.0),
                  ),
                ],
              ),
            ),
            loading?Loading():Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: <Widget>[
                  signInButton(
                    text: "Sign in with Google",
                    image: "assets/google-logo.png",
                    color: Colors.white,
                    textcolor: Colors.black,
                    onPressed:_signInWithGoogle,
                    borderRadius:20,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  signInButton(
                    text: "Log in with Email",
                    icon: Icon(Icons.person),
                    color: Colors.teal[700],
                    textcolor: Colors.white,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Login(),
                      ));
                    },
                    borderRadius:20,
                  ),
                  SizedBox(
                    height:8.0,
                  ),
                  signInButton(
                    text: "Sign up with Email",
                    icon: Icon(Icons.email),
                    color: Colors.grey[900],
                    textcolor: Colors.white,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>SignUp()
                      ));
                    },
                    borderRadius:20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
