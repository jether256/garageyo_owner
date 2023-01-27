

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/provider/washPro.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class washlist extends StatefulWidget {
  const washlist({Key? key}) : super(key: key);

  @override
  _washlistState createState() => _washlistState();
}

class _washlistState extends State<washlist> {

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

  @override
  void initState() {

    showSeve();
    super.initState();
  }

  late List serve = [];
  Future showSeve() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/wash/bays.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        serve = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Service',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                IconButton(
                    onPressed:(){
                          Navigator.pop(context);
                    },
                    icon:const Icon(Icons.close,color: Colors.white,)
                ),
              ],
            ),

          ),
          FutureBuilder(
            future:showSeve(),
            builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){

              if (snapshot.hasData) {

                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:serve.length ,
                      itemBuilder:(context,index){


                        return Waaa(
                          saID:serve[index]['id'],
                          saTitle:serve[index]['service'],
                          saPic:'https://bodayo.000webhostapp.com/admin/ajax/washing/${serve[index]['pic']}',

                        );

                      }),
                );

              }else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}


class Waaa extends StatefulWidget {
  final String saID;
  final String saTitle;
  final String saPic;

  Waaa({ required this.saID, required this.saTitle, required this.saPic});


  @override
  _WaaaState createState() => _WaaaState();
}

class _WaaaState extends State<Waaa> {
  @override
  Widget build(BuildContext context) {

    var _washPro=Provider.of<WashServiceProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:NetworkImage(
          widget.saPic,
        ) ,
      ),
      title: Text(widget.saTitle),
      onTap: (){

        _washPro.selectedWash(widget.saTitle);
        Navigator.pop(context);
      },
    );
  }
}
