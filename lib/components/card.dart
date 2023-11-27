import 'package:flutter/material.dart';
import 'package:food_donation_app/utility/constants.dart';

class CardContiner extends StatelessWidget {
  const CardContiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          color: Colors.grey.shade50,
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image(image: AssetImage('asset/food.jpg'),fit:BoxFit.cover,),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8)),
              ),
              Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Food Title',
                            style: Heading3.copyWith(fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Restaurent Name"),
                          Row(
                            children: [
                              Text('time'),
                              SizedBox(
                                width: 40,
                              ),
                              Text('qty/person')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
