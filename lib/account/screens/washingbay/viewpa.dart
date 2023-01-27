import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/screens/washingbay/adpa.dart';
import 'package:garageyo_owner/account/screens/washingbay/packCard.dart';

import '../../custom_drawer.dart';


class ViewPack extends StatefulWidget {
  static const  String id='viewPa';
  @override
  _ViewPackState createState() => _ViewPackState();
}

class _ViewPackState extends State<ViewPack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packages List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                          Text('Packages'),
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
                      Navigator.pushReplacementNamed(context,AddPackage.id);
                    },
                  ),
                ],
              ),
            ),
          ),


          const Expanded(
            child: PackCard(),
          ),
        ],
      ),
    );
  }
}
