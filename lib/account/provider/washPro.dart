import 'package:flutter/material.dart';



class WashServiceProvider with ChangeNotifier{

  String selectedWService='not selected';

  selectedWash(selected){
    selectedWService=selected;
    notifyListeners();

  }
}