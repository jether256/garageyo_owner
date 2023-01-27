import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/screens/garage/garagecard.dart';


import '../../custom_drawer.dart';

import 'addGarage.dart';
class Garage extends StatefulWidget {
  static const  String id='garage';

  @override
  _GarageState createState() => _GarageState();
}

class _GarageState extends State<Garage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Service List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      drawer: CustomD(),
      body:Column(
        children: [
          Material(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Row(
                        children: const [
                          Text('Services'),
                          SizedBox(width:10),
                          CircleAvatar(
                            backgroundColor: Colors.black54,
                            maxRadius: 8,
                            child: FittedBox(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('20',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],

                      ),
                    ),
                  ),

                  MaterialButton(
                    color:Colors.lightBlue,
                    child:const Text('Add',style: TextStyle(color: Colors.white),),
                    onPressed:(){
                      Navigator.pushReplacementNamed(context,addGarage.id);
                    },
                  ),
                ],
              ),
            ),
          ),

          const Expanded(
            child: GarageCard(),
          ),
        ],
      ),
    );
  }
}
