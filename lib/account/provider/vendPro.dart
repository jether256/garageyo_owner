
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;





class BusinessProvider with ChangeNotifier {


  //late List<List<dynamic>> bizData;

  var bizData;


  getBusinessDetails(details){
    this.bizData=details;
    notifyListeners();

  }



}


