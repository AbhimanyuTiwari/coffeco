import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
BoxDecoration bodyBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.purple, Colors.pink[200]]));


final inputDecoration=InputDecoration(
  fillColor: Colors.grey[300],
  filled: true,
);

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 50,
      child: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}