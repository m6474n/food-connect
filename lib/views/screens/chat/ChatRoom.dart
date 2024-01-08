import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/messageField.dart';
import 'package:food_donation_app/controller/chatroomController.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:food_donation_app/views/screens/authentication/login.dart';
import 'package:food_donation_app/views/screens/chat/ChatScreen.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  final String ReceiverName;
  final String ReceiverId;
  const MessageScreen(
      {super.key, required this.ReceiverName, required this.ReceiverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
 FirebaseAuth auth = FirebaseAuth.instance;
 FirebaseFirestore dbRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String chatRoomId = '${auth.currentUser!.uid}_${widget.ReceiverId}';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ReceiverName),
      ),
      body: StreamBuilder(
        stream: dbRef.collection('chat_room').doc(chatRoomId).collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData){
            return Text('Something went wrong!');
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){

                var alignment = (snapshot.data.docs[index]['sender'] == auth.currentUser!.uid)? Alignment.centerRight:Alignment.centerLeft;
return Message(message:snapshot.data.docs[index]['message'], alignment: alignment,);

                    });
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),

        child: Row(
          children: [
            Expanded(
                child: MessageField(
                    label: 'Type anything...', controller: messageController)), IconButton(onPressed: (){}, icon: Icon(Icons.send, color: mainColor,size: 32,))
          ],
        ),
      ),
    );

  }

}

class Message extends StatelessWidget {
  final String message;
  final Alignment alignment;

  const Message({super.key, required this.message, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        // alignment: alignment,
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: mainColor,
        borderRadius: BorderRadius.circular(12)
        ),
        child: Text(message,style: paragraph.copyWith(color: Colors.white),),),
    );
  }
}
