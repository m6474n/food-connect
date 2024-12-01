import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/AdminController.dart';
import 'package:get/get.dart';

class ManageNGOs extends StatefulWidget {
  const ManageNGOs({super.key});

  @override
  State<ManageNGOs> createState() => _ManageNGOsState();
}

class _ManageNGOsState extends State<ManageNGOs> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AdminController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              title: Text('Available NGOs'),
            ),
            body: controller.getNGOs(),
          );
        });
  }
}
