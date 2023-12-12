// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   final ref = FirebaseFirestore.instance.collection('chat_room').doc('2fVGGBqo0MVpZqvJcMG8hCKL53X2_TwS8O59QLybVU6IhADfoo3OU1aN2').collection('messages').snapshots();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(stream: ref, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//        var document = snapshot.data.docs;
//        return ListView.builder(itemBuilder: (context,index){ return ListTile(
//          title: Text(snapshot.data.doc[index]['message']),
//        );});
//
//       },)
//     );
//   }
// }
// //