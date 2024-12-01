import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/UserProfileController.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:get/get.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: UserProfile(),
        builder: (controller){
      return Scaffold(
        body: SafeArea(
          child: Column(children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(children: [Expanded(
                  flex: 1,
                  child: CircleAvatar(radius: 40,)),SizedBox(width: 10,), Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style: Heading2.copyWith(fontSize: 20),)
                      ,Text("email@email.com",style: paragraph.copyWith(color: Colors.black87),)
                    ],)),Expanded(flex:1,child: IconButton(onPressed: (){},icon: Icon(Icons.edit),))],),
            ),
            SizedBox(height: 10,),
            Divider(thickness: 2,color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ListTile(title: Text("Active donations", style: paragraph.copyWith(color: Colors.black87),),),
            ),
            Divider(thickness: 1,color: Colors.grey.withOpacity(0.3),),

          ],),
        )
      );
    });
  }
}
