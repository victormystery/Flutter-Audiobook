import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

  final books = FirebaseFirestore.instance.collection('books').snapshots();

  //updating user data
  Future updateUserData(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": fullname,
      "email": email,
      "phone_number": "",
      "profile_picture": "",
      "playlist": [],
    });
  }

  //getting user data from firebase
  Future getUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future getAudio() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> audioSnapshot = await FirebaseFirestore.instance
        .collection('books')
        .doc()
        .collection('audio')
        .snapshots();
  }
}
