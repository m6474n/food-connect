import 'package:flutter/material.dart';
import 'package:food_donation_app/components/messageField.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/login.dart';
import 'package:food_donation_app/views/screens/chat/ChatScreen.dart';

class MessageScreen extends StatelessWidget {
  final String name;
  final String uid;
  const MessageScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(onPressed: (){
        //
        // },icon: Icon(Icons.arrow_back),),
        title: ListTile(
          leading: CircleAvatar(),
          title: Text(
            name,
            style: paragraph.copyWith(color: mainColor, fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ListView()),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(
                      child: MessageField(
                    label: 'Type Something',
                    validator: (value) {},
                    keyboardType: TextInputType.text,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        // color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Icon(Icons.send, color: mainColor,size: 38,))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
