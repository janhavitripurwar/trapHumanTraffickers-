import 'package:flutter/material.dart';
import 'package:traptrafikkers/screens/authenticate/register.dart';
import 'package:traptrafikkers/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(()=> showSignIn=!showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView : toggleView); //property : val
    }else {
      return Register(toggleView : toggleView); //property name any value name same as function
    }
  }
}
