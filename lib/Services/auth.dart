import 'dart:async';

import 'package:coffeco/Services/DataServices.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
String errorMessage;
class User{
  final String uid;
  User({this.uid});
}

class AuthServices{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth=FirebaseAuth.instance;
  User _userfromFirebase(FirebaseUser user){
    return (user!=null)?User(uid:user.uid):null;
  }
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userfromFirebase);
  }
  Future<User> signUpwithEmail(String email, String password) async{
    try {
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await DataServices(uid: user.uid).updateUserData("new menber", "0", 100);
      return _userfromFirebase(user);

    }catch(e){
      errorHandling(e);
      print(e.toString());
      return null;
    }
  }
  String get errors{
    return errorMessage;
  }
  Future<User> logInwithEmail(String email, String password) async{
    try {
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userfromFirebase(user);
  }catch(e){
      errorHandling(e);
      return null;
    }
  }
  Future<User> signOut() async{
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
  }
  Future<User> signInWithGoogle() async {
    String name;
    String sugar;
    int strength;
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        try{
          await DataServices(uid: authResult.user.uid).userData.forEach((event) {
          name=event.name??"new member";
          sugar=event.sugar??"0";
          strength=event.strength??100;
        });

        await DataServices(uid: authResult.user.uid).updateUserData(name,sugar,strength);
        }catch(e){
          await DataServices(uid: authResult.user.uid).updateUserData("new member","0",100);
        }


        return _userfromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }


}
void errorHandling(error){
  switch (error.code) {
    case "ERROR_INVALID_EMAIL":
      errorMessage = "Invalid Email id/Password";
      break;
    case "ERROR_WRONG_PASSWORD":
      errorMessage = "Invalid Email id/Password";
      break;
    case "ERROR_USER_NOT_FOUND":
      errorMessage = "User not found";
      break;
    case "ERROR_USER_DISABLED":
      errorMessage = "User with this email has been disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
      errorMessage = "Too many requests. Try again later.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
      errorMessage = "Signing in with Email and Password is not enabled.";
      break;
    default:
      errorMessage = "An undefined Error happened.";
  }
}