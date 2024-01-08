import 'dart:convert';
import 'dart:ui';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/controller/Role_manager.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  NotificationServices _services = NotificationServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> tokens = ['',''];
    // return Scaffold(
    //   body: Center(
    //       child: ElevatedButton(
    //     onPressed: () {
    //
    //       _services.getDeviceToken().then((value) async {
    //         print(value);
    //         print (RoleController().role);
    //
    //           var data = {
    //             // 'to': '',
    //             'to': value,
    //             'priority': 'high',
    //             'notification': {
    //               'title': 'Test Notification from virtual machine',
    //               'body': 'This notification is sent from virtual machine'
    //             },
    //             'data': {
    //               'type': 'notification',
    //               'id': '112234'
    //             }
    //
    //           };
    //           await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //               body: jsonEncode(data),
    //               headers: {
    //                 'Content-Type': 'application/json; charset=UTF-8',
    //                 'Authorization':
    //                 'AAAA_btdJwM:APA91bHXlPEVwjfZMlynTjV-ehG-wZd4i6JD9rBaAazYrHI6GdePVjPgb4iwU33FMXTaERSP48eBngscyLdHblmOzApkOCWf8lHe44yrjIFCu_poKdCrjno2UP_wLUkmZW1t_KgMptWt',
    //               });
    //         }
    //
    //       );
    //     },
    //     child: Text('Send Notification'),
    //   )),
    // );
    return SingleChildScrollView(
      child: Column(children: [
        // DonationCard(),
      ],),
    );
  }
}
