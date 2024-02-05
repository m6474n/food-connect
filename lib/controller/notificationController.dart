import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
class NotificationController extends GetxController{
 NotificationServices services = NotificationServices();

  @override
  void onInit() {
    // TODO: implement onInit

    services.requestNotificationServices();


    services.firebaseInit();
    super.onInit();
  }



 sendNotification(String Restaurent, String item){
   services.getDeviceToken().then((value)async {
     // == val.toString()? '': val.toString()
     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
         'Devices').get();
     snapshot.docs.forEach((doc) async {
       String val = doc['token'];
       var data = {
         'to': doc['role'] == "NGO" ?  val == value ? "": val :"",
         'priority': 'high',
         'notification': {
           'title': 'New Donation Added! from $Restaurent',
           'body': 'Item: $item'
         }};
       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
           body: jsonEncode(data),
           headers: {
             'Content-Type': 'application/json; charset=UTF-8',
             'Authorization':
             'key=AAAA_btdJwM:APA91bHXlPEVwjfZMlynTjV-ehG-wZd4i6JD9rBaAazYrHI6GdePVjPgb4iwU33FMXTaERSP48eBngscyLdHblmOzApkOCWf8lHe44yrjIFCu_poKdCrjno2UP_wLUkmZW1t_KgMptWt'
           });

       print("Done!");
     });
   });}
 sendMessageNotification(String sender, String message,String token)async{
   var data = {
     'to': token,
     'priority': 'high',
     'notification': {
       'title': '$sender',
       'body': '$message'
     }};
   await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
       body: jsonEncode(data),
       headers: {
         'Content-Type': 'application/json; charset=UTF-8',
         'Authorization':
         'key=AAAA_btdJwM:APA91bHXlPEVwjfZMlynTjV-ehG-wZd4i6JD9rBaAazYrHI6GdePVjPgb4iwU33FMXTaERSP48eBngscyLdHblmOzApkOCWf8lHe44yrjIFCu_poKdCrjno2UP_wLUkmZW1t_KgMptWt'
       });
}
}