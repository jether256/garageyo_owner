import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login.dart';
import 'login/regsiter.dart';


import 'package:garageyo_owner/location.dart';

class Wait extends StatefulWidget {
  static const  String id='wait';
  @override
  _WaitState createState() => _WaitState();
}

class _WaitState extends State<Wait> {

  String? userID,name,email,num, pass, pic,lon, lat,ad, city,country,status,type,log,create;
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

    Navigator.pushReplacementNamed(context,LoginForm.id);
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        actions:  [

          InkWell(
            onTap: (){

              signOut();
            },
            child: const Icon(
              Icons.login,

            ),
          ),

          const SizedBox(width: 20,),

          InkWell(
            onTap: (){

              Navigator.pushReplacementNamed(context,Register.id);
            },
            child: const Icon(
              Icons.exit_to_app,

            ),
          ),

const SizedBox(width: 20,),

          InkWell(
            onTap: (){

              Navigator.pushReplacementNamed(context,locationL.id);
            },
            child: const Icon(
              CupertinoIcons.location,

            ),
          ),
        ],
      ),
        body: Center(
          child: Column(
            children: [
              Text('$name'),
              Text('$email'),
              Text('$num'),
              Text('$pass'),
            ],
          ),
        ),
    );
  }
}
