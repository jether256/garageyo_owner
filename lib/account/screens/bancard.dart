import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';


class BannerCard extends StatefulWidget {
  const BannerCard({Key? key}) : super(key: key);

  @override
  _BannerCardState createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {



  @override
  void initState() {
    getPref();
    getBusiness();
    showType();
    super.initState();
  }


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

  String? ID, user_id, logo, shop, bizname, email1, num1, tax, tin, add, time,
      sta, serve, op, rat, tRat, picked;

  getBusiness() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ID = sharedPreferences.getString(BusinessInfo.ID);
    user_id = sharedPreferences.getString(BusinessInfo.user_id);
    logo = sharedPreferences.getString(BusinessInfo.logo);
    shop = sharedPreferences.getString(BusinessInfo.shop);
    bizname = sharedPreferences.getString(BusinessInfo.bizname);
    email1 = sharedPreferences.getString(BusinessInfo.email1);
    num1 = sharedPreferences.getString(BusinessInfo.num1);
    tax = sharedPreferences.getString(BusinessInfo.tax);
    tin = sharedPreferences.getString(BusinessInfo.tin);
    add = sharedPreferences.getString(BusinessInfo.add);
    time = sharedPreferences.getString(BusinessInfo.time);
    sta = sharedPreferences.getString(BusinessInfo.sta);
    serve = sharedPreferences.getString(BusinessInfo.serve);
    op = sharedPreferences.getString(BusinessInfo.op);
    rat = sharedPreferences.getString(BusinessInfo.rat);
    tRat = sharedPreferences.getString(BusinessInfo.tRat);
    picked = sharedPreferences.getString(BusinessInfo.picked);
  }

  //https://bodayo.000webhostapp.com/api/owner/addBana.php
  late List ban = [];
  Future showType() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/getBana.php"),
        body:{"user_id": '$user_id'},
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        ban = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }

  // delete(ban) async {
  //
  //   var response=await http.post(Uri.parse('https://bodayo.000webhostapp.com/api/owner/delBana.php'),
  //
  //       body:{"id":ban});
  //
  //
  //
  //   if(response.statusCode==200){
  //     var userData=json.decode(response.body);
  //
  //     if(userData=="yes"){
  //
  //
  //       showDialog(
  //         context: (context),
  //         builder:(context)=> AlertDialog(
  //           title:const Text('Message'),
  //           content:const Text('Banner Deleted Successfully') ,
  //           actions:<Widget> [
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor:MaterialStateProperty.all(Colors.deepOrangeAccent ),
  //               ),
  //               onPressed:(){
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Cancel'),),
  //
  //           ],
  //         ),
  //       );
  //
  //
  //
  //     }else{
  //
  //
  //
  //
  //       showDialog(
  //         context: (context),
  //         builder:(context)=> AlertDialog(
  //           title:const Text('Message'),
  //           content:const Text('Banner Failed to delete') ,
  //           actions:<Widget> [
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor:MaterialStateProperty.all(Colors.deepOrangeAccent),
  //               ),
  //               onPressed:(){
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Cancel'),),
  //
  //           ],
  //         ),
  //       );
  //       print(userData);
  //     }
  //
  //   }
  //
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:showType(),
      builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){

        if (snapshot.hasData) {

          return Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount:ban.length ,
                itemBuilder:(context,index){

                  return Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: CachedNetworkImage(
                            imageUrl:'https://bodayo.000webhostapp.com/api/owner/bana/${ban[index]['image']}',fit: BoxFit.fill,
                          ),
                        ),
                      ),

                       Positioned(
                        right: 10,
                        top: 10,
                        child:CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon:Icon(Icons.delete_outline,),
                            color: Colors.red,
                           onPressed: (){
                              EasyLoading.show();
                              del(ban[index]['id']);
                              EasyLoading.dismiss();
                           },
                          ),
                        ),
                      ),
                    ],
                  );

                }),
          );

        }else{

          return GFShimmer(
              showShimmerEffect: true,
              mainColor: Colors.grey.shade500,
              secondaryColor: Colors.grey.shade400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(

                    color: Colors.grey.shade300,
                    width: MediaQuery.of(context).size.width,
                    height: 200,

                  ),
                ],
              )
          );
        }
      },
    );
  }

  Future<void> del(ban) async {
    var response=await http.post(Uri.parse('https://bodayo.000webhostapp.com/api/owner/delBana.php'),

              body:{"id":ban});



          if(response.statusCode==200){
            var userData=json.decode(response.body);

            if(userData=="yes"){


              showDialog(
                context: (context),
                builder:(context)=> AlertDialog(
                  title:const Text('Message'),
                  content:const Text('Banner Deleted Successfully') ,
                  actions:<Widget> [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(Colors.deepOrangeAccent ),
                      ),
                      onPressed:(){
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),),

                  ],
                ),
              );



            }else{




              showDialog(
                context: (context),
                builder:(context)=> AlertDialog(
                  title:const Text('Message'),
                  content:const Text('Banner Failed to delete') ,
                  actions:<Widget> [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(Colors.deepOrangeAccent),
                      ),
                      onPressed:(){
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),),

                  ],
                ),
              );
              print(userData);
            }

          }



  }
}
