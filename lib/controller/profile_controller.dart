import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProfilerProvider extends ChangeNotifier{
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection("Users");


}