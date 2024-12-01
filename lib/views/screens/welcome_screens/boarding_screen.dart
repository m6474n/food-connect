import 'package:flutter/material.dart';
import 'package:food_donation_app/components/onboard_content.dart';
import 'package:food_donation_app/models/onboard_model.dart';
import 'package:food_donation_app/routes/route_name.dart';

import 'package:food_donation_app/views/screens/welcome_screens/welcome_screen.dart';
import 'package:get/get.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late PageController _controller;

  void nextPage() {
    _controller.page == data.length - 1
        ? Get.to(WelcomeScreen())
        : _controller.nextPage(
            duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  void previousPage() {
    _controller.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final List<OnBoard> data = [
    OnBoard(
        text: 'no_food_waste!'.tr,
        paragraph:
            "first_screen_description".tr,
        image: "asset/banner 1.jpg"),
    OnBoard(
        text: 'we_are_in_it_together'.tr,
        paragraph: "second_screen_description".tr,
        image: "asset/banner 2.jpg"),
    OnBoard(
        text: 'just_one_tap'.tr,
        paragraph: "third_screen_description".tr,
        image: "asset/banner 3.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            itemCount: data.length,
            controller: _controller,
            itemBuilder: (context, index) => OnBoardContent(
                  text: data[index].text,
                  paragraph: data[index].paragraph,
                  image: data[index].image,
                  indicator: _controller,
                  onPressNext: () => nextPage(),
                  onPressPrevious: () {
                    previousPage();
                  },
                )));
  }
}
