import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garageyo_owner/Provider/locationPro.dart';
import 'package:garageyo_owner/login/login.dart';
import 'package:garageyo_owner/pref/pref.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../wait.dart';

class Mapma extends StatefulWidget {
  static const  String id='map';

  @override
  _MapmaState createState() => _MapmaState();
}

class _MapmaState extends State<Mapma> {

  late LatLng currentLocation;
  late GoogleMapController _googleMapController;

  bool _locating = false;

  String? userID, name, email, num, pass, pic, lon, lat, ad, city, country,
      status, type, log, create;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      city = sharedPreferences.getString(PrefInfo.city);
      country = sharedPreferences.getString(PrefInfo.country);
      status = sharedPreferences.getString(PrefInfo.status);
      type = sharedPreferences.getString(PrefInfo.type);
      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
    });
  }


  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefInfo.ID);
    sharedPreferences.remove(PrefInfo.name);
    sharedPreferences.remove(PrefInfo.email);
    sharedPreferences.remove(PrefInfo.num);
    sharedPreferences.remove(PrefInfo.pass);
    sharedPreferences.remove(PrefInfo.pic);
    sharedPreferences.remove(PrefInfo.lon);
    sharedPreferences.remove(PrefInfo.lat);
    sharedPreferences.remove(PrefInfo.ad);
    sharedPreferences.remove(PrefInfo.city);
    sharedPreferences.remove(PrefInfo.country);
    sharedPreferences.remove(PrefInfo.status);
    sharedPreferences.remove(PrefInfo.type);
    sharedPreferences.remove(PrefInfo.log);
    sharedPreferences.remove(PrefInfo.create);

    Navigator.pushReplacementNamed(context, LoginForm.id);
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }


  Future<void> upDateAd(Map<String, dynamic> map, BuildContext context) async {
    var response = await http.post(
        Uri.parse('https://bodayo.000webhostapp.com/api/owner/updatelo.php'),
        body: map);
    //var result = json.decode(response.body);

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, Wait.id);

      showDialog(
        context: (context),
        builder: (context) =>
            AlertDialog(
              title: const Text('Message'),
              content: const Text('Location saved successfully'),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),),

              ],
            ),
      );
    } else {
      showDialog(
        context: (context),
        builder: (context) =>
            AlertDialog(
              title: const Text('Message'),
              content: const Text('Location failed to save'),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),),

              ],
            ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {

    final locationData=Provider.of<LocationProvider>(context);

    setState(() {
      currentLocation=LatLng(locationData.latitude,locationData.longitude);
    });

    void onCreated(GoogleMapController mapController){
      setState(() {
        _googleMapController=mapController;
      });
    }

    return Scaffold(
      body: SafeArea(

        child: Stack(

          children: [


            Expanded(
              child: GoogleMap(
                initialCameraPosition:CameraPosition(
                  target:currentLocation,
                  zoom: 14.4746,
                ),
                zoomControlsEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(
                  1.5,20.8,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                onCameraMove:(CameraPosition position){

                  setState(() {
                    _locating=true;
                  });
                  locationData.onCameraMove(position);
                },
                onMapCreated: onCreated,
                onCameraIdle:() {
                  setState(() {
                    _locating=false;
                  });
                  locationData.getMoveCamer();
                },
              ),
            ),


            Center(
              child: Container(
                height: 50,
                margin:const EdgeInsets.only(bottom: 40),
                child: Image.asset('assets/images/marker.png'),
              ),
            ),

            const Center(
              child: SpinKitPulse(
                color: Colors.lightBlue,
                size: 100.0,
              ),
            ),

            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _locating ? LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      ):Container(),

                  TextButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.location_searching,color: Theme.of(context).primaryColor,),
                      label:Text(_locating ? 'Locating....' :locationData.selectedAdress.featureName,overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Text(locationData.selectedAdress.addressLine),
                  ),

                      const SizedBox(height: 25,),


                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width-40,//40 is padding from both sides
                          child: AbsorbPointer(
                            absorbing: _locating ? true:false,
                            child: MaterialButton(
                              child: Text('Save Location',style: TextStyle(color: Colors.white),),
                              color: _locating ? Colors.grey:Colors.lightBlue,
                                onPressed:(){

                                locationData.saveLoc();
                                  upDateAd({
                                    'id':'$userID',
                                    'address':'${locationData.selectedAdress.addressLine}',
                                    'lon':'${locationData.longitude}',
                                    'lat':'${locationData.latitude}',

                                  },context);


                                },
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
