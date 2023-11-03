import 'package:flutter/foundation.dart';

class DynamicList extends ChangeNotifier{
  List<String> _list = [];
  DynamicList(this._list);
  List get list => _list;
void addToList(item){
  list.add(item);
  notifyListeners();
}
}