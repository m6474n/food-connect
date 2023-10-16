import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class CardContiner extends StatelessWidget {
  const CardContiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
        // color:    mainColor.withOpacity(0.1),
            // color: Colors.grey.shade200,
            // border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage('./asset/food.jpg'),
                          fit: BoxFit.cover)),
                )),
            Expanded(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'Just added',
                            style: paragraph.copyWith(
                                color: mainColor, fontSize: 12),
                          )),
                      Text(
                        'Biryani',
                        style: Heading3.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'st#2, Some location',
                        style:paragraph.copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(backgroundImage: AssetImage('./asset/ngo_profile.jpg'),radius: 12,),
                              SizedBox(
                                width: 8,
                              ),
                              Text('NGO Name',style: paragraph.copyWith(color: Colors.black, fontSize: 14))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('4.7 rating', style: paragraph.copyWith(fontSize: 12),)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 16,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '1.2 miles',
                                style: paragraph.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                color: Colors.grey,
                                size: 16,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '21 reviews',
                                style: paragraph.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
