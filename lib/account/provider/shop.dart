import 'package:flutter/material.dart';

class ShopProvider with ChangeNotifier{

  String selectedCategory='not selected';

  selectedKat(selected){
    selectedCategory=selected;
    notifyListeners();

  }
}