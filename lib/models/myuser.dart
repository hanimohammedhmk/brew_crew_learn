import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? uid;

  MyUser({this.uid});
}

class UserData {
  final String? uid;
  final String name;
  final String sugar;
  final int strength;

  UserData(
      {this.uid,
      required this.name,
      required this.sugar,
      required this.strength});
}
