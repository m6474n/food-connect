import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/add_post.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final dbRef = FirebaseFirestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(children: [
          SearchField(),
          SizedBox(height: 60,),
          StreamBuilder<QuerySnapshot>(stream: dbRef, builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator(color: mainColor,);
            }
            if(snapshot.hasError){
              Utils.toastMessage('Something went wrong!', Colors.red);
            }
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(snapshot.data!.docs[index]['message'].toString()),
                    );
                  }),
            );
          }),






        ],),
      ),
        floatingActionButton: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPost()));},child: Icon(Icons.add),),),
    );
  }
}
