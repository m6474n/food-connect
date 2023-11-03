import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/components/RoundedButton.dart';
import 'package:food_donation_app/models/list_model.dart';
import 'package:food_donation_app/models/product_model.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:provider/provider.dart';

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
  final prod = TextEditingController();
  final qty = TextEditingController();
final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    postController.dispose();
    postNode.dispose();
    super.dispose();
  }
List<List<String >>  _items = [['qut', "1"],
  ['product 2', '40']
];
  List<Products> products = [];
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<DynamicList>(context);

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
            SizedBox(height: 30,),
            Form(
             key:  _formKey,
              child: Row(children: [
                Expanded(
                  child: InputField(
                      controller: prod,
                      keyboardType: TextInputType.text,
                      validator: (value) {},
                      focusNode: postNode,
                      icon: Icons.keyboard,
                      label: 'Enter Product'),
                ),SizedBox(width: 20,),
                Expanded(
                  child: InputField(
                      controller: qty ,
                      keyboardType: TextInputType.text,
                      validator: (value) {},
                      focusNode: postNode,
                      icon: Icons.keyboard,
                      label: 'Enter Quantity'),
                ),
              ],),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
                label: 'Add Post',
                bgColor: mainColor,
                onPress: () {
                  //
                  // if(_formKey.currentState!.validate()){
                  //   provider.addToList(prod.text.toString());
                  // }

                  // db.doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
                  //   'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  //   'message': postController.text
                  // }).then((value) {
                  //   print('Post Added Successfully!');
                  //   postController.clear();
                  // }).onError((error, stackTrace) {
                  //   print('Something went wrong!');
                  // });


                },
                labelColor: Colors.white,
                loading: false),
            SizedBox(height: 30,),
            // Expanded(child: ListView.builder(
            //     itemCount: _items.length,
            //     itemBuilder: (context, index){
            //       return ListItems(product: _items[index][0].toString(), quantity: _items[index][1].toString());
            //     })),
            Expanded(child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index){
                  return ListItems(product: _items[index][0].toString(), quantity: _items[index][1].toString());
                }))
          ],
        ),
      ),
    );
  }
}
class ListItems extends StatelessWidget {
  const ListItems({super.key, required this.product, required this.quantity});
final String product, quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product , style: paragraph,),
        trailing: Text(quantity, style: paragraph.copyWith(color: mainColor),),
      ),
    );
  }
}


