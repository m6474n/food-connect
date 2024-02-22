import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/controller/notificationController.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../components/card.dart';
import '../utility/constants.dart';

class DonationController extends GetxController{
bool isLoading = false;
  final productController = TextEditingController();
  final qtyController = TextEditingController();
  NotificationServices notify = NotificationServices();
  String? dropdownValue;
    final notificationController = Get.put(NotificationController());
  // final date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime dateRef = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String status = 'active';
  var preprationTime;
  var location;
  final name = FirebaseAuth.instance.currentUser!.displayName;
  final donorId =FirebaseAuth.instance.currentUser!.uid ;
  String id = "112233";
  final uuid = Uuid();
  @override
  void onInit() {
    // TODO: implement onInit
    id = uuid.v4();
    super.onInit();
    print(location);
  }

  showDropdown(){return DropdownButton<String>(
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

        dropdownValue = newValue!;
      update();
    },
  );}


  timePicker(BuildContext context)async {
    final TimeOfDay? prepTime = await showTimePicker(
        context: context, initialTime: timeOfDay);
    if (prepTime != null) {
      timeOfDay = prepTime;
      preprationTime = timeOfDay.hour;

      update();
    }


    @override
    void onClose() {
      // TODO: implement onClose
      super.onClose();
      productController.dispose();
      qtyController.dispose();
    }
  }

  addDonation(){
    EasyLoading.show(status: 'Donating...');
    getCurrentLocation().then((value)async {
      FirebaseFirestore.instance.collection('donations').add({
        'id': id,
        'donated by': name,
        'donor_Id': donorId,
        'status': status,
        'date': dateRef,
        'type': dropdownValue,
        'prep time': timeOfDay.hour,
        "item": productController.text,
        'quantity': qtyController.text,

        'lat': value.latitude,
        'long': value.longitude,
        'isDeleted': false
      }).then((value) {
        EasyLoading.showSuccess('Donation Added');
        productController.clear();
        qtyController.clear();
      }).onError((error, stackTrace) {
          EasyLoading.showError(error.toString());
      });
        update();
      notificationController.sendNotification("$name", "${productController.text} for ${qtyController.text} people");
    });
  }

  //
  // Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
  //     context: context,
  //     initialDate: dateRef,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2200));
  //
  // Future<TimeOfDay?> pickTime(BuildContext context) => showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay(hour: timeOfDay.hour, minute: timeOfDay.minute));





  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'Location permission disabled!', 'Turn on the location service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Permission Denied', 'Turn on the location service');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location permissions are permanently denied',
          'We can not request the permissions');
    }
    return await Geolocator.getCurrentPosition();
  }


  
  getDonations(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('donations')
          .where('donor_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('something_went_wrong'.tr));
        }
        if (snapshot.data.docs.isEmpty) {
          return Center(
              child: Text(
                'no_active_donation_available'.tr,
                style: paragraph,
              ));
        }
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var donationData = snapshot.data!.docs[index].data();
              var isDeleted = donationData['isDeleted'] == false;

              return isDeleted
                  ? DonationCard(
                item: snapshot.data!.docs[index]['item'],
                quantity: snapshot.data!.docs[index]['quantity'],
                restaurentName: snapshot.data!.docs[index]
                ['donated by'],
                time: snapshot.data!.docs[index]['prep time'] ==
                    null
                    ? ""
                    : snapshot.data!.docs[index]['prep time'],
                status: snapshot.data!.docs[index]['status'],
                onTap: () async {
                  // Show a bottom sheet with options (e.g., delete)
                  Get.bottomSheet(
                    BottomSheet(
                      onClosing: () {},
                      builder: (_) {
                        return Container(
                          height: 70,
                          padding: EdgeInsets.only(top: 6),
                          child: ListTile(
                            onTap: () async {
                              // Get the reference to the document
                              var documentReference =
                              FirebaseFirestore.instance
                                  .collection('donations')
                                  .doc(snapshot.data!.docs[index].id);

                              // Delete the document
                              await documentReference.delete();

                              // Close the bottom sheet
                              Get.back();
                            },
                            leading: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Delete',
                              style: paragraph.copyWith(color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }, type: snapshot.data!.docs[index]['status'],
              )
                  : Container();
            },
          ),
        );
      },
    );
    
    
  }



}