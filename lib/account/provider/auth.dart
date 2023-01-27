




import 'package:flutter/cupertino.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:location/location.dart';

class AuthProvider extends ChangeNotifier{
  double shopLatitude=0.0;
  double shopLongitude=0.0;
   String? shopAdd;
   String? placeName;


  Future getCurrentAddress() async{
    Location location= new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }


    _locationData = await location.getLocation();
    this.shopLatitude=_locationData.latitude!;
    this.shopLongitude=_locationData.longitude!;
    notifyListeners();

    final coordinates= Coordinates(_locationData.latitude!,_locationData.longitude!);
    var _addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var shopAdress=_addresses.first;
    this.shopAdd=shopAdress.addressLine;
    this.placeName=shopAdress.featureName;
   notifyListeners();
   return shopAdress;

  }
}