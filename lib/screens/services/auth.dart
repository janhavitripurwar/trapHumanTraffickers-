import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:traptrafikkers/models/user.dart';
import 'package:traptrafikkers/screens/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 static String  UID="";                    //global string used for setting document id same as user.uid

  //create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    //    .map((FirebaseUser user) => _userFromFirebaseUser(user));   //firebase user changed to our user
          .map(_userFromFirebaseUser);    //simple way to do above thing

  }

  //sign in with Anonymous
Future signInAnon () async {
  try{
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
}

  //sign in with email & password
  Future signInWithEmailAndPassword (String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword (String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
     // print('user.uid is : ');
      //print(user.uid);
      UID = user.uid;
      // print('UID FROM REGISTER');
      // print(UID);
      //create a new document for the user with uid
      //await DatabaseService(uid: user.uid).updateUserData('0', '0', '0');

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signOut
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //adding trusted contacts to collection with doc id==user id
  Future updateDocument(String contact1,String contact2,String contact3) async{
    try{
      print('UID Is :');
      print(UID);
       await DatabaseService(uid: UID).updateUserData(contact1,contact2,contact3);
       return UID;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}