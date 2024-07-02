// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String phoneNo;
  String profilePhoto;
  String uid;
  User({
    required this.name,
    required this.uid,
    required this.profilePhoto,
    required this.phoneNo,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        'phoneNo': phoneNo,
        "uid": uid,
        'profilePhoto': profilePhoto
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      phoneNo: snapshot['phoneNo'],
      profilePhoto: snapshot['profilePhoto'],
      name: snapshot['name'],
      uid: snapshot['uid'],
    );
  }
}
