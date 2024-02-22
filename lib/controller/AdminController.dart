import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/card.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final userStream = FirebaseFirestore.instance.collection('Users').snapshots();
  final donationStream =

      FirebaseFirestore.instance.collection('donations').snapshots();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


}
getUserList(){
  return StreamBuilder(stream: FirebaseFirestore.instance.collection("Users").snapshots(), builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return CircularProgressIndicator(color: Colors.white,);
      }
    return  Text(
      "${snapshot.data!.docs.length -1}",
      style: paragraph.copyWith(
          fontSize: 38,
          color: Colors.white,
          fontWeight: FontWeight.bold),
    );

  });
}

getDonationList(){
    return StreamBuilder(stream: FirebaseFirestore.instance.collection("donations").snapshots(), builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return CircularProgressIndicator(color: Colors.white,);
      }
      return  Text(
       snapshot.data!.docs.length.toString(),
        style: paragraph.copyWith(
            fontSize: 38,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      );

    });

}

  getRestaurants() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: mainColor,),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Something went wrong!"));
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var id = snapshot.data!.docs[index]['id'];

                return snapshot.data!.docs[index]['role'] != "Admin" && snapshot.data!.docs[index]['isDeleted'] != true && snapshot.data!.docs[index]['role'] != "NGO"? ListTile(
                  onTap: (){
                    Get.bottomSheet(
                      BottomSheet(
                        onClosing: () {},
                        builder: (_) {
                          return Container(
                            height: 70,
                            padding: EdgeInsets.only(top: 6),
                            child: ListTile(
                              onTap: () async {
                                // Get the reference to the document
                                var documentReference =
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(snapshot.data!.docs[index].id);

                                // Delete the document
                                await documentReference.delete();

                                // Close the bottom sheet
                                Get.back();
                              },
                              leading: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Delete',
                                style: paragraph.copyWith(color: Colors.red),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  leading:snapshot.data!.docs[index]['image'] == ""? CircleAvatar(child: Icon(Icons.person),radius: 32,): CircleAvatar(
                    radius: 32,
                    backgroundImage: snapshot.data!.docs[index]['image'],),
                  title: Text(snapshot.data!.docs[index]['name']),
                  subtitle: Text(snapshot.data!.docs[index]['email']),
                  trailing: Text(snapshot.data!.docs[index]['role']),
                ):Container();
              });
        });
  }
  getNGOs() {
    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: mainColor,),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Something went wrong!"));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
                  'No active user available',
                  style: paragraph,
                ));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var id = snapshot.data!.docs[index]['id'];

                return snapshot.data!.docs[index]['role'] != "Admin" && snapshot.data!.docs[index]['isDeleted'] != true && snapshot.data!.docs[index]['role'] != "Restaurant"? ListTile(
                  onTap: (){
                    Get.bottomSheet(
                      BottomSheet(
                        onClosing: () {},
                        builder: (_) {
                          return Container(
                            height: 70,
                            padding: EdgeInsets.only(top: 6),
                            child: ListTile(
                              onTap: () async {
                                // Get the reference to the document
                                var documentReference =
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(snapshot.data!.docs[index].id);

                                // Delete the document
                                await documentReference.delete();

                                // Close the bottom sheet
                                Get.back();
                              },
                              leading: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              title: Text(
                                'Delete',
                                style: paragraph.copyWith(color: Colors.red),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  leading:snapshot.data!.docs[index]['image'] == ""? CircleAvatar(child: Icon(Icons.person),radius: 32,): CircleAvatar(
                    radius: 32,
                    backgroundImage: snapshot.data!.docs[index]['image'],),
                  title: Text(snapshot.data!.docs[index]['name']),
                  subtitle: Text(snapshot.data!.docs[index]['email']),
                  trailing: Text(snapshot.data!.docs[index]['role']),
                ):Container();
              });
        });
  }


  getDonations() {
    return StreamBuilder(
        stream: donationStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: mainColor,),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Something went wrong!"));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
                  'No donation available',
                  style: paragraph,
                ));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return DonationCard(
                    item: "item",
                    quantity: "quantity",
                    restaurentName: "restaurentName",
                    time: 12,

                    status: "status",
                    onTap: () {
                      Get.bottomSheet(
                        BottomSheet(
                          onClosing: () {},
                          builder: (_) {
                            return Container(
                              height: 70,
                              padding: EdgeInsets.only(top: 6),
                              child: ListTile(
                                onTap: () async {
                                  // Get the reference to the document
                                  var documentReference =
                                  FirebaseFirestore.instance
                                      .collection('donations')
                                      .doc(snapshot.data!.docs[index].id);

                                  // Delete the document
                                  await documentReference.delete();

                                  // Close the bottom sheet
                                  Get.back();
                                },
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  'Delete',
                                  style: paragraph.copyWith(color: Colors.red),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    type: "Veg");
              });
        });
  }




}
