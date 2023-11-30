import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:food_donation_app/controller/Session_manager.dart';
import 'package:food_donation_app/models/UserModel.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final dbRef = FirebaseFirestore.instance.collection("Users");
  final db = FirebaseFirestore.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool _loading = false;

  bool get Loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

// final _picker = Image
  final _picker = ImagePicker();
  File? _image;

  File? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      // uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camer'),
                    onTap: () {
                      pickCameraImage(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                    onTap: () {
                      pickGalleryImage(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/Profile Image - ' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask = ref.putFile(File(_image!.path));
    await Future.value(uploadTask);
    final newUrl = await ref.getDownloadURL();

    dbRef
        .doc(SessionController().userId)
        .update({'image': newUrl.toString()}).then((value) {
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString(), Colors.red);
    });
  }

  Future<UserModel> getUserData(String email) async {
    final snapshot =
        await db.collection('Users').where("email", isEqualTo: email).get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapsshot(e)).single;
    return userData;
  }

  logutUser(BuildContext context){
   setLoading(true);
    auth.signOut().then((value){
      setLoading(false);
      Navigator.pop(context);
      Utils.toastMessage('Logout Successfully', Colors.green);
    });
  }


}
