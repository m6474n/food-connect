import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/utility/constants.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final db = FirebaseFirestore.instance.collection('posts');
  final auth = FirebaseAuth.instance;
  final postController = TextEditingController();
  final postNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    postController.dispose();
    postNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(
                controller: postController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                focusNode: postNode,
                icon: Icons.keyboard,
                label: 'Type Anything'),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
                label: 'Add Post',
                bgColor: mainColor,
                onPress: () {
                  db.doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'message': postController.text
                  }).then((value) {
                    print('Post Added Successfully!');
                    postController.clear();
                  }).onError((error, stackTrace) {
                    print('Something went wrong!');
                  });
                },
                labelColor: Colors.white,
                loading: false)
          ],
        ),
      ),
    );
  }
}
