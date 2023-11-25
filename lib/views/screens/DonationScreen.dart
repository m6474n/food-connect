import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/InputField.dart';
import 'package:food_donation_app/models/product_model.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:provider/provider.dart';

import '../../models/list_Provider.dart';
import '../../models/list_model.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final productController = TextEditingController();
  final qtyController = TextEditingController();
  final productNode = FocusNode();
  final qtyNode = FocusNode();
  final List _list = [];

  addProduct(value) {
    setState(() {
      _list.add(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.dispose();
    qtyController.dispose();
    productNode.dispose();
    qtyNode.dispose();

  }
final ref = FirebaseFirestore.instance.collection('donation');
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ListProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Donate',
          style: Heading1.copyWith(fontSize: 24),
        )),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            color: Colors.grey,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: productController,
                        decoration: InputDecoration(hintText: 'Items'),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: qtyController,
                        decoration: InputDecoration(hintText: 'Servings'),
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      // addProduct(Products(
                      //     item: productController.value.text,
                      //     quantity: qtyController.value.text));
                      final product = Products(item: productController.text, quantity: qtyController.text);
                      final user = product.toJson();
                      addProduct(user);
                      productController.clear();
                      qtyController.clear();


print(_list);

                    },
                    child: Icon(Icons.add))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _list.length,
                  // itemCount: provider.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_list[index]['product']),
                      trailing: Text(_list[index]['quantity']),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GradientButton(label: 'Donate', onPress: (){


            }, loading: false),
          )
        ],
      ),
    );
  }
}
