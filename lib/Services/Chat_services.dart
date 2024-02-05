import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/notificationController.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/models/message_model.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:get/get.dart';

class ChatServices extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  NotificationController controller = Get.put(NotificationController());

  Future<void> sendMessage(String receiverId, String message) async {

//     get user info
    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

// create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

// construct chatroom if from current user id and receiver id
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

// add new message to database

    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());


    //send notification

NotifyUser(receiverId, message);

   // controller.sendMessageNotification(auth.currentUser!.displayName.toString(), message, token)



    // Get Messages from Database




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
  }
  NotifyUser(String receiverId, String message)async{
    final data = await  FirebaseFirestore.instance.collection('Devices').doc(receiverId).get();
    var token = data['token'];

    controller.sendMessageNotification(auth.currentUser!.displayName.toString(), message, token);

  }

}
