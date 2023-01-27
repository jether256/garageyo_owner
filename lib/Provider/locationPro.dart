


import 'package:flutter/cupertino.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier{

   double latitude=0.0;
   double longitude=0.0;

  bool permissionAllowed=false;
  bool loading=false;


      late LocationPermission permission;

  var selectedAdress;

 Future<void> getCurrentPosition() async{



   permissionAllowed = await Geolocator.isLocationServiceEnabled();
   if (!permissionAllowed) {
     return Future.error('Location services are disabled.');
   }

   permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
     if (permission == LocationPermission.denied) {

       return Future.error('Location permissions are denied');
     }
   }



    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if(position!=null){


      latitude=position.latitude;
      longitude=position.longitude;

      final coordinates= Coordinates(latitude, longitude);
      final addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
      selectedAdress=addresses.first;



      permissionAllowed=true;
 
      notifyListeners();
    }else{
     // _permissionGranted = await location.requestPermission();
      print('Permission not allowed');

    }


  }


  void onCameraMove(CameraPosition cameraPosition)async{
    latitude=cameraPosition.target.latitude;
    longitude=cameraPosition.target.longitude;
    notifyListeners();
  }


  Future<void>getMoveCamer() async{
   final coordinates= Coordinates(latitude, longitude);
   final addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
   selectedAdress=addresses.first;
   print("${selectedAdress.featureName}:${selectedAdress.addressLine}");


  }

  Future  saveLoc() async {

   SharedPreferences prefs=await SharedPreferences.getInstance();
   prefs.setDouble('lat', this.latitude);
   prefs.setDouble('lon', this.longitude);
   prefs.setString('address',this.selectedAdress.addressLine);
   prefs.setString('location', this.selectedAdress.featureName);

  }

}

