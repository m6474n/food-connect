import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_donation_app/Services/DestinationController.dart';
import 'package:food_donation_app/Services/SourceController.dart';
import 'package:food_donation_app/controller/mappController.dart';
import 'package:food_donation_app/controller/routeController.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/chat/ChatPage.dart';
import 'package:food_donation_app/views/screens/map/donationMap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationDetails extends StatefulWidget {
  final String item, type, serving, donerId, donerName, id;

  final int time;
  const DonationDetails(
      {super.key,
      required this.item,

      required this.type,
      required this.serving,
      required this.time,
      required this.donerId,
      required this.donerName, required this.id,
      });

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  // ValueNotifier<bool> value = ValueNotifier<bool>(true);
RouteController controller = Get.put(RouteController());
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Donation Details')),
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('./././asset/food.jpg'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 150),
                // padding: EdgeInsets.all(32),
                child: Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32)),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableRow(
                        title: 'Item:',
                        text: widget.item,
                      ),
                      ReusableRow(
                        title: 'Serving:',
                        text: widget.serving,
                      ),
                      ReusableRow(
                        title: 'Prep Time:',
                        text: widget.time.toString(),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print(SourceController().source);
                                  print(DestinationController().destination);
                               // controller.addSourceToFirebase();
                               controller.addDestinationToFirebase();
                              Get.to(()=>DonationMap(id: widget.id,restaurantId: widget.donerId,restaurantName: widget.donerName,));

                                  print(widget.id);


                              },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: Text(
                                    'Get Donation',
                                    style: paragraph.copyWith(
                                        color: Colors.black87, fontSize: 18),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                 Get.to(ChatPage(
                                                receiverUserName:
                                                    widget.donerId,
                                                receiverUserId:
                                                    widget.donerName,
                                              ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: Text('Chat',
                                          style: paragraph.copyWith(
                                              color: Colors.white,
                                              fontSize: 18))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  final String title, text;
  const ReusableRow({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: paragraph.copyWith(color: Colors.black87, fontSize: 16),
            ),
          )),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              text,
              style: paragraph.copyWith(color: Colors.black87, fontSize: 16),
            ),
          )),
        ],
      ),
    );
  }
}

Future<void> popUp(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
          ),
        );
      });
}
