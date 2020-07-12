import 'package:coffeco/HomePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication/Authentication.dart';
import 'Services/auth.dart';
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    if(user==null)
    return Authentication();
    else
    return homePage();
  }
}
