import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier{
  List<String> list =[];
  void addItem(String item){
    list.add(item);
    notifyListeners();
  }
}