import 'package:flutter/material.dart';

class signInButton extends StatelessWidget {
  final String image;
  final Color color;
  final Color textcolor;
  final Icon icon;
  final VoidCallback onPressed;
  final String text;
  final double borderRadius;

  signInButton(
      {@required this.text,
      this.image,
      this.color,
      this.textcolor,
      this.icon,
      this.onPressed,
      this.borderRadius});
    Widget decider(){
      if(image==null&&icon==null)
        return SizedBox(height:0,);
      else if(image!=null)
        return Image.asset(image);
      else
        return icon;
    }
  @override
  Widget build(BuildContext context) {
    //print(icon);
    return SizedBox(
      height: 50,


      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             decider(),
              Text(text, style: TextStyle(color: textcolor, fontSize: 15.0)),
              Opacity(
                opacity: 0.0,
                child: decider(),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0.0)),
        ),
        onPressed: onPressed ,
        color: color ?? Colors.white,
        textColor: textcolor ?? Colors.black,
        padding: EdgeInsets.all(5),
      ),
    );
  }
}
