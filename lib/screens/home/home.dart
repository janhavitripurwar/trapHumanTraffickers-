import 'package:flutter/material.dart';
import 'package:traptrafikkers/screens/home/contacts.dart';
import 'package:traptrafikkers/screens/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Record'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout')
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Record ', style: TextStyle(color: Colors.white,fontSize: 20.0)),
                  onPressed: () async {}
              ),
              SizedBox(height: 42.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text('My Trusted Contacts', style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  onPressed: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => Contacts()
                    ));
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
