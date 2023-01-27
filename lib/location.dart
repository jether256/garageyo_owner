import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/locationPro.dart';
import 'login/login.dart';
import 'map/map.dart';


class locationL extends StatefulWidget {
  static const  String id='locat';

  // final bool locationChanging;
  //
  // locationL({required this.locationChanging});

  @override
  _locationLState createState() => _locationLState();
}

class _locationLState extends State<locationL> {

  bool _loading=true;



  @override
  Widget build(BuildContext context) {

    final locationData=Provider.of<LocationProvider>(context,listen:false);


    //fetching location from the db
    // if(widget.locationChanging==null){
    //
    //
    //   if(document['address']!=null){
    //     //means location has already been updated
    //     setState(() {
    //       _loading=true;
    //     });
    //
    //     Navigator.pushReplacementNamed(context,Wait.id);
    //   }else{
    //     setState(() {
    //       _loading=false;
    //     });
    //   }
    //
    //
    //
    // }else{
    //   setState(() {
    //     _loading=false;
    //   });
    //
    // }


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [


            Expanded(child: Image.asset('assets/images/location.png')),
            const Text('Set Your Location...',style: TextStyle(fontSize: 25,color:Colors.lightBlue,fontWeight: FontWeight.w700),),
            const Text('Ready to join the biggest business family',style: TextStyle(color:Colors.lightBlue,)),
            const SizedBox(height: 20,),
            MaterialButton(
              color: Colors.lightBlue,
                child:locationData.loading ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),

                ) :
                const Text('Set location',style: TextStyle(color: Colors.white),),

                onPressed:() async{

                setState(() {
                  locationData.loading=true;
                });

                 await locationData.getCurrentPosition();
                 if(locationData.permissionAllowed==true){



                   Navigator.pushReplacementNamed(context,Mapma.id);
                   setState(() {
                     locationData.loading=false;
                   });
                 }else{
                   setState(() {
                     locationData.loading=false;
                   });

                   print('Permission not allowed');
                 }



                },

            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }


}
