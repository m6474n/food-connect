import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/controller/LocationController.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/dashboards/dashboard.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController nameController = TextEditingController();
  final nameNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  final emailNode = FocusNode();

  TextEditingController phoneController = TextEditingController();
  final phoneNode = FocusNode();

  TextEditingController addressController = TextEditingController();
  final addressNode = FocusNode();

  String? dropdownValue;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context, listen: true);
    final locationProvider =
        Provider.of<LocationController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'complete_profile'.tr,
          style: paragraph.copyWith(color: mainColor, fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100),
                        child: provider.image == null
                            ? Icon(
                                Icons.person,
                                size: 48,
                                color: mainColor,
                              )
                            : Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          FileImage(File(provider.image!.path)),
                                      fit: BoxFit.cover),
                                ),
                              )),
                    Positioned(
                      top: 90,
                      left: 80,
                      child: GestureDetector(
                        onTap: () {
                          provider.pickImage(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: mainColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade100)),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey.shade100,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        hintText: 'phone'.tr,
                        hintStyle: paragraph,
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        locationProvider.getCurrentLocation();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 12),
                        alignment: Alignment.centerLeft,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey.shade100),
                        child: Text(
                          locationProvider.Address,
                          style: paragraph,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 12),
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade100),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(children: [
                              Text(
                                'food_you_prefer'.tr,
                                style: paragraph.copyWith(fontSize: 16),
                              ),
                            ]),
                          ),
                          Expanded(
                            child: Center(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                items: const [
                                  DropdownMenuItem<String>(
                                      value: 'Restaurant',
                                      child: Text('Veg',
                                          style: TextStyle(
                                              fontSize: 16, color: textColor))),
                                  DropdownMenuItem<String>(
                                      value: 'NGO',
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
                    )),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GradientButton(
                label: 'update'.tr,
                onPress: () {
                  provider.uploadImage(context);
                  provider.completeUserProfile(phoneController.text,
                      locationProvider.Address, dropdownValue);
                 Get.to(DashboardScreen());
                      },
                loading: provider.Loading),
          ),
        ],
      ),
    );
  }
}
