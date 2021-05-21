import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traptrafikkers/screens/home/home.dart';
import 'package:traptrafikkers/screens/authenticate/authenticate.dart';
import 'package:traptrafikkers/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user==null){
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}
