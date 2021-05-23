import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid}) {}

  //collection reference
  final CollectionReference trustedContactsCollection = Firestore.instance.collection('trustedContacts');

  Future updateUserData(String contact1, String contact2,String contact3) async {
   // print('jjjjj');
    return await trustedContactsCollection.document(uid).setData({
      'contact1' :contact1,
      'contact2' :contact2,
      'contact3' :contact3,
    });
  }
  //get firebase stream
  Stream<QuerySnapshot> get contacts{
    return trustedContactsCollection.snapshots();
  }
}