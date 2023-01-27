import 'package:flutter/material.dart';



class GaraProvider with ChangeNotifier{

  String selectedGara='not selected';

  selectedGal(selected){
    selectedGara=selected;
    notifyListeners();

  }
}