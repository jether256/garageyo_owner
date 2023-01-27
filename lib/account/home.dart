import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'custom_drawer.dart';


class HomeScreen extends StatefulWidget {

  static const  String id='home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    //
    // var _busProvider=Provider.of<BusinessProvider>(context);
    //
    // if


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('DashBoard',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      drawer:CustomD(),

    );
  }
}
