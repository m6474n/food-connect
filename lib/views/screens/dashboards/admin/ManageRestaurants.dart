import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/AdminController.dart';
import 'package:get/get.dart';

class ManageRestaurants extends StatefulWidget {
  const ManageRestaurants({super.key});

  @override
  State<ManageRestaurants> createState() => _ManageRestaurantsState();
}

class _ManageRestaurantsState extends State<ManageRestaurants> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AdminController(),
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
              title: Text('Available Restaurent'),
            ),
            body: controller.getRestaurants(),
          );
        });
  }
}
