import 'package:flutter/material.dart';



class typeProvider with ChangeNotifier{

  String selectedCarType='not selected';

  selectedCar(selected){
    selectedCarType=selected;
    notifyListeners();

  }
}