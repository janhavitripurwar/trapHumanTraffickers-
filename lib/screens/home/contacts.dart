import 'package:flutter/material.dart';
import 'package:traptrafikkers/shared/contants.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
 String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Mobile Numbers'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Contact 1'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Contact 2'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Contact 3'),
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Done', style: TextStyle(color: Colors.white),),
                    onPressed: () async {

                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color:  Colors.red,fontSize: 14.0),
                )
              ],
            ),
          )
      ),
    );
  }
}
