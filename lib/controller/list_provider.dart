import 'package:flutter/foundation.dart';

class ListProvider extends ChangeNotifier{
  List<String> list=[];


  void addToList(String items)
  {
    list.add(items);
    notifyListeners();
  }

  void removeFromList(int index){
    list.removeAt(index);
    notifyListeners();
  }

}