import 'dart:convert';
import 'package:food_donation_app/controller/notificationController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/donationField.dart';
import 'package:food_donation_app/Services/LocationManager.dart';
import 'package:food_donation_app/Services/Session_manager.dart';
import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:provider/provider.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({super.key});

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  final productController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.dispose();
    qtyController.dispose();
  }

  String? dropdownValue;

  // final date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateRef = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String status = 'active';
  var preprationTime;
  var location ;

  void getUserData() async {
    var ref = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      location = ref['address'];
    });
  }



  @override
  void initState() {
    // TODO: implement initState
 getUserData();
 print(location);

    super.initState();
  }

  NotificationServices notify = NotificationServices();

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<DonationController>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_donations'.tr,
          style: Heading1.copyWith(fontSize: 24),
        ),
      ),
      body: GetBuilder(
        init: NotificationController(),
        builder: (controller){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    final TimeOfDay? prepTime = await showTimePicker(
                        context: context, initialTime: timeOfDay);
                    if (prepTime != null) {
                      setState(() {
                        timeOfDay = prepTime;
                        preprationTime = timeOfDay.hour;
                      });
                      return;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        // border:Border.all(width: 1, color: mainColor)
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'prep_time'.tr,
                          style: paragraph.copyWith(color: mainColor),
                        ),
                        Text(
                          '${timeOfDay.hour}:${timeOfDay.minute}',
                          style: paragraph.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 14, right: 14),
                alignment: Alignment.centerLeft,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(children: [
                        Text(
                          'food_type'.tr,
                          style:
                          paragraph.copyWith(fontSize: 16, color: mainColor),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          items: const [
                            DropdownMenuItem<String>(
                                value: 'Veg',
                                child: Text('Veg',
                                    style: TextStyle(
                                        fontSize: 16, color: textColor))),
                            DropdownMenuItem<String>(
                                value: 'Non-Veg',
                                child: Text('Non-Veg',
                                    style: TextStyle(
                                        fontSize: 16, color: textColor)))
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: DonationField(
                          controller: productController,
                          keyboardType: TextInputType.text,
                          validator: (value) {},
                          label: 'item'.tr,
                        )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: DonationField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          validator: (value) {},
                          label: 'quantity'.tr,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GradientButton(
                label: 'donate'.tr,
                onPress: () {
                   controller.sendNotification("Restaurent", "item");

                      FirebaseFirestore.instance.collection('donations').add({
                        'id': FirebaseAuth.instance.currentUser!.uid,
                        'donated by':
                        FirebaseAuth.instance.currentUser!.displayName,
                        'status': status,
                        'date': dateRef,
                        'type': dropdownValue,
                        'prep time': timeOfDay.hour,
                        "item": productController.text,
                        'quantity': qtyController.text,
                        'location': location
                      }).then((value) {
                        Utils.toastMessage("Donation added!", Colors.green);
                        // notify.sendNotification(
                        //     FirebaseAuth.instance.currentUser!.displayName
                        //         .toString(),
                        //     productController.text);



                        productController.clear();
                        qtyController.clear();
                      }).onError((error, stackTrace) {
                        Utils.toastMessage(error.toString(), Colors.red);
                      });

                    }, loading: false,),
            ],
          ),
        );
      },),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateRef,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute));
}
