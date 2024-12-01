import 'package:flutter/material.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/donation/donationDetails.dart';
import 'package:get/get.dart';

class CardContiner extends StatelessWidget {
  final String item, quantity, restaurentName, address, status;
  final int time;
  final VoidCallback onTap;
  const CardContiner(
      {super.key,
      required this.item,
      required this.quantity,
      required this.restaurentName,
      required this.time,
      required this.address,
      required this.status,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String image = 'asset/food.jpg';
    final String preptime = '${DateTime.now().hour - time} hours ago';
    final String serving = '$quantity people';
    final String restaurant = restaurentName;
    final String location = address;

    return Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: Heading3.copyWith(fontSize: 18),
                              ),
                            ),
                            RoleController().role == 'NGO'
                                ? Container()
                                : Expanded(
                                    child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: status == 'active'
                                                  ? Colors.green.shade100
                                                  : Colors.yellow.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            status,
                                            textAlign: TextAlign.right,
                                          )),
                                    ),
                                  ))
                          ],
                        ),
                        Text(
                          restaurentName,
                          style: paragraph.copyWith(color: Colors.black),
                        ),
                        RichText(
                            text: DateTime.now().hour - time < 0
                                ? TextSpan(
                                    text: 'Will prepare in: ',
                                    children: [
                                      TextSpan(
                                          text:
                                              ' ${(DateTime.now().hour - time) * -1} hour',
                                          style: paragraph.copyWith(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ],
                                    style: paragraph.copyWith(
                                        color: mainColor, fontSize: 14))
                                : TextSpan(
                                    text: 'Prepared:',
                                    children: [
                                      TextSpan(
                                          text:
                                              ' ${DateTime.now().hour - time == 0 ? 'Now' : DateTime.now().hour - time} hours ago',
                                          style: paragraph.copyWith(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ],
                                    style: paragraph.copyWith(
                                        color: mainColor, fontSize: 14))),
                        RichText(
                            text: TextSpan(
                                text: 'For:',
                                children: [
                                  TextSpan(
                                      text: ' $quantity people',
                                      style: paragraph.copyWith(
                                          color: Colors.black, fontSize: 14)),
                                ],
                                style: paragraph.copyWith(
                                    color: mainColor, fontSize: 14))),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}

class DonationCard extends StatelessWidget {
  final String item, quantity, restaurentName, status, type;
  final int time;
  final VoidCallback onTap;
  const DonationCard(
      {super.key,
        required this.item,
        required this.quantity,
        required this.restaurentName,
        required this.time,
        required this.status,
        required this.onTap, required this.type});



  @override
  Widget build(BuildContext context) {
    final String image = 'asset/food.jpg';
    final String preptime = '${DateTime.now().hour - time}' +'hours ago'.tr;
    final String serving = '$quantity people';
    final String restaurant = restaurentName;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Container(
                    padding: EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  child: Center(
                                      child: Text(
                                    preptime,
                                    style:

                                        paragraph.copyWith(
                                            fontSize: 12,
                                            color: Colors.white),
                                  )),
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(12)),
                                ))
                          ],
                        ))),
                        Expanded(
                            child: Container(
                                child: RoleController().role == "Restaurant"
                                    ? Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                child: Center(
                                                    child: Text(
                                                  status.tr,
                                                  style: paragraph.copyWith(fontSize: 12,
                                                      color: Colors.white),
                                                )),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              ))
                                        ],
                                      )
                                    : Container()))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: paragraph.copyWith(
                          color: mainColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      type.tr,
                      style: paragraph.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      restaurant,
                      style: paragraph.copyWith(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "serving_for".tr+ quantity+ 'people'.tr,
                      style: paragraph.copyWith(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
