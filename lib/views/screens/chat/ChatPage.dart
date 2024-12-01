import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/messageField.dart';
import 'package:food_donation_app/Services/Chat_services.dart';
import 'package:food_donation_app/controller/chatroomController.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserId;

  const ChatPage(
      {super.key,
      required this.receiverUserName,
      required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatServices _chatService = ChatServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, messageController.text);
      messageController.clear();
    }
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUSerId) {
    List<String> ids = [userId, otherUSerId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserName),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget buildMessageList(){
    return StreamBuilder(
        stream: getMessages(auth.currentUser!.uid, widget.receiverUserId),
        builder: (context, snapshot){
          if(snapshot.hasError)
            {
              return Text("Error${snapshot.error}");

            }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading...");

          }
          return ListView(
            children: snapshot.data!.docs.map((document) => buildMessageItems(document)).toList(),
          );

        });



  }


  Widget buildMessageItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChatBubble(
          backGroundColor: data['senderId'] == auth.currentUser!.uid? mainColor: Colors.grey,
          alignment: alignment,
          clipper: ChatBubbleClipper1(type: data['senderId'] == auth.currentUser!.uid? BubbleType.sendBubble:BubbleType.receiverBubble),
        child: Text(data['message'], style: paragraph.copyWith(color: Colors.white),
          ),
        // child: Container(
        //   width: MediaQuery.of(context).size.width *0.8,
        //   //,
        //   // height: 30,
        //     decoration: BoxDecoration(color: data['senderId'] == auth.currentUser!.uid? mainColor : Colors.grey),
        //   alignment: alignment,
        //   padding: EdgeInsets.all(12),
        //   child: Text(data['message'], style: paragraph.copyWith(color: Colors.white),),
        // ),
      ),
    ));
  }

  Widget buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  child: MessageField(
            label: 'enter_message'.tr,
            controller: messageController,
          ))),
          IconButton(onPressed: sendMessage, icon: Icon(Icons.send, size: 48,color: mainColor,))
        ],
      ),
    );
  }
}
