import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  List<QuerySnapshot<Map<String,dynamic>>> ids =[];
  Future<void> getData() async{
    var  res = await FirebaseFirestore.instance.collection('chat_room').get();
    // ids.addAll(res.docs);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection('chat_room').snapshots(),
        builder: (context, snapshot){
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
            return Text('e');

          });
        },),
      ),
    );
  }
}
