import 'package:flutter/material.dart';



class WashPackProvider with ChangeNotifier{

  String selectedWPack='not selected';

  selectedPack(selected){
    selectedWPack=selected;
    notifyListeners();

  }
}