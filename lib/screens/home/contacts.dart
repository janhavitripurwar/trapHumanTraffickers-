import 'package:flutter/material.dart';
import 'package:traptrafikkers/shared/contants.dart';
import 'package:traptrafikkers/screens/services/database.dart';
import 'package:traptrafikkers/screens/services/auth.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService _auth = AuthService();
 String error="";
 String win="";
 String contact1="", contact2="", contact3="";

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
                 // validator: (val) => val.length!=10 ? "Enter valid mobile number " : null,
                  onChanged: (val){
                    setState(() => contact1 =val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Contact 2'),
                 // validator: (val) => val.length!=10 ? "Enter valid mobile number " : null,
                  onChanged: (val){
                    setState(() => contact2 =val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'Contact 3'),
                 // validator: (val) => val.length!=10 ? "Enter valid mobile number " : null,
                  onChanged: (val){
                    setState(() => contact3 =val);
                  },
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Done', style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                     dynamic result = await _auth.updateDocument(contact1, contact2, contact3);
                     // print('result is :');
                     // print(result);
                     // print(error);
                     if(result==null){
                       setState(() {
                         error = 'failed';
                         //loading = false;
                       });
                     }
                     else {
                       setState(() {
                         win = 'Successfully Added!! ';
                         //loading = false;
                       });
                     }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color:  Colors.red,fontSize: 14.0),
                ),
                Text(
                  win,
                  style: TextStyle(color: Colors.green,fontSize: 20.0,fontWeight:FontWeight.bold),
                )
              ],
            ),
          )
      ),
    );
  }
}
