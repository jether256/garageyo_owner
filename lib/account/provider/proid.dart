import 'package:flutter/material.dart';

class ProductIDProvider with ChangeNotifier{

  String? selectedProduct;

  selectedPro(selected){
    selectedProduct=selected;
    notifyListeners();

  }
}