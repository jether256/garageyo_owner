import 'package:flutter/material.dart';


import '../../custom_drawer.dart';
import 'addWash.dart';
import 'baycard.dart';


class WashingBay extends StatefulWidget {
  static const  String id='wash';
  @override
  _WashingBayState createState() => _WashingBayState();
}

class _WashingBayState extends State<WashingBay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                      Navigator.pushReplacementNamed(context,AddWash.id);
                    },
                  ),
                ],
              ),
            ),
          ),


           const Expanded(
            child: BayCard(),
          ),
        ],
      ),
    );
  }
}
