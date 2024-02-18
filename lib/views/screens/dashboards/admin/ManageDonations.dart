import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/AdminController.dart';
import 'package:get/get.dart';

class ManageDonations extends StatefulWidget {
  const ManageDonations({super.key});

  @override
  State<ManageDonations> createState() => _ManageDonationsState();
}

class _ManageDonationsState extends State<ManageDonations> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AdminController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              title: Text('Donations'),
            ),
            body: controller.getDonations(),
          );
        });
  }
}
