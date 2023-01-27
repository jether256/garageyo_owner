import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/home.dart';
import 'package:garageyo_owner/account/provider/vendPro.dart';
import 'package:garageyo_owner/login/regsiter.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class linda extends StatefulWidget {


  late final bool? waitVerification;

  static const  String id='linda';

  @override
  _lindaState createState() => _lindaState();
}

class _lindaState extends State<linda> {

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
    //Funa();

    showBiz();

    getBusiness();

    super.initState();
  }





  //get business array
  Funa() async {

    var response=await http.post(Uri.parse('https://bodayo.000webhostapp.com/api/owner/biz.php'),
        body:{'user_id':'$userID'});



    if(response.statusCode==200){
      var jsonData=json.decode(response.body);

      String ID=jsonData['ID'];
      String user_id=jsonData['user_id'];
      String logo=jsonData['logo'];
      String shop=jsonData['shopImage'];
      String bizname=jsonData['bizname'];
      String email=jsonData['email1'];
      String num=jsonData['phone1'];
      String tax=jsonData['taxRegistered'];
      String tin =jsonData['tinNumber'];
      String add=jsonData['address'];
      String  time=jsonData['time1'];
      String  sta=jsonData['status1'];
      String serve=jsonData['service'];
      String op=jsonData['shopOpen'];
      String rat=jsonData['rating'];
      String tRat=jsonData['totalRating'];
      String picked=jsonData['isTopPicked'];


      if(jsonData=="ERROR"){



      }else{

        saveBusiness(ID,user_id,logo,shop,bizname,email,num,tax,tin,add,time,sta,serve,op,rat,tRat,picked);


        if(jsonData['status1']=='verified'){
          Navigator.pushReplacementNamed(context,HomeScreen.id);
        }

        else if(jsonData['status1']=='waitverification'){
            showBiz();
        }






        print(jsonData);
      }

    }else{

      Navigator.pushReplacementNamed(context,Register.id);
    }



  }


//get business list
  late List biz = [];
  Future showBiz() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/biz2.php"),
        headers: {"Accept": "headers/json"},body:{'user_id':'$userID'});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        biz = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }

  saveBusiness(String ID,String  user_id,String logo,String shop,String bizname,String email1,String num1,String tax,String tin,
      String add,String time,String sta,String serve,String op,String rat,String tRat,String picked) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(BusinessInfo.ID, ID);
      sharedPreferences.setString(BusinessInfo.user_id, user_id);
      sharedPreferences.setString(BusinessInfo.logo, logo);
      sharedPreferences.setString(BusinessInfo.shop, shop);
      sharedPreferences.setString(BusinessInfo.bizname,bizname);
      sharedPreferences.setString(BusinessInfo.email1,email1);
      sharedPreferences.setString(BusinessInfo.num1, num1);
      sharedPreferences.setString(BusinessInfo.tax, tax);
      sharedPreferences.setString(BusinessInfo.tin, tin);
      sharedPreferences.setString(BusinessInfo.add,add);
      sharedPreferences.setString(BusinessInfo.time, time);
      sharedPreferences.setString(BusinessInfo.sta,sta);
      sharedPreferences.setString(BusinessInfo.serve,serve);
      sharedPreferences.setString(BusinessInfo.op, op);
      sharedPreferences.setString(BusinessInfo.rat, rat);
      sharedPreferences.setString(BusinessInfo.tRat, tRat);
      sharedPreferences.setString(BusinessInfo.picked, picked);
    });

}

  String? ID,user_id,logo,shop,bizname,email1,num1,tax,tin,add,time, sta, serve,op,rat,tRat,picked;
getBusiness() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  ID = sharedPreferences.getString(BusinessInfo.ID);
  user_id = sharedPreferences.getString(BusinessInfo.user_id);
  logo= sharedPreferences.getString(BusinessInfo.logo);
  shop= sharedPreferences.getString(BusinessInfo.shop);
  bizname= sharedPreferences.getString(BusinessInfo.bizname);
   email1= sharedPreferences.getString(BusinessInfo.email1);
   num1= sharedPreferences.getString(BusinessInfo.num1);
   tax= sharedPreferences.getString(BusinessInfo.tax);
   tin= sharedPreferences.getString(BusinessInfo.tin);
  add = sharedPreferences.getString(BusinessInfo.add);
  time = sharedPreferences.getString(BusinessInfo.time);
   sta= sharedPreferences.getString(BusinessInfo.sta);
   serve= sharedPreferences.getString(BusinessInfo.serve);
   op= sharedPreferences.getString(BusinessInfo.op);
   rat= sharedPreferences.getString(BusinessInfo.rat);
   tRat= sharedPreferences.getString(BusinessInfo.tRat);
   picked= sharedPreferences.getString(BusinessInfo.picked);
}





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:FutureBuilder<dynamic>(
            future:showBiz(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
              Funa();

              if (snapshot.hasData) {


                    return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: biz.length,
                            itemBuilder: (context, index) {
                            return Kalabe(
                            ID: biz[index]['ID'],

                            logo: 'https://bodayo.000webhostapp.com/api/owner/logo/${biz[index]['logo']}',
                            shop: 'https://bodayo.000webhostapp.com/api/owner/shop/${biz[index]['shopImage']}',
                            biz: biz[index]['bizname'],
                            phon: biz[index]['phone1'],
                            mail: biz[index]['email1'],
                            tax: biz[index]['taxRegistered'],
                            tin: biz[index]['tinNumber'],
                            ad: biz[index]['address'],
                            time: biz[index]['time1'],
                            stat: biz[index]['status1'],
                            serve: biz[index]['service'],
                               );
                            });

                        } else {

                      return GFShimmer(
                        showShimmerEffect: true,
                        mainColor: Colors.lightBlue.shade500,
                        secondaryColor: Colors.lightBlue.shade400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.lightBlue.shade300,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,

                            ),
                          ],
                        )
                      );

                     }
                }



    ),
    );

  }



  }








class Kalabe extends StatefulWidget {



final String ID;

  final String logo;
  final String shop;
  final String biz;
  final String phon;
  final String mail;
  final String tax;
  final String tin;
  final String ad;
  final String time;
  final String stat;
  final String serve;

  Kalabe({required this.logo, required this.shop, required this.biz, required this.phon, required this.mail, required this.tax, required this.tin, required this.ad, required this.time, required this.stat, required this.serve, required this.ID});

  @override
  _KalabeState createState() => _KalabeState();
}

class _KalabeState extends State<Kalabe> {

  String? ID,user_id,logo,shop,bizname,email1,num1,tax,tin,add,time, sta, serve;
  getBusiness() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    ID = sharedPreferences.getString(BusinessInfo.ID);
    user_id = sharedPreferences.getString(BusinessInfo.user_id);
    logo= sharedPreferences.getString(BusinessInfo.logo);
    shop= sharedPreferences.getString(BusinessInfo.shop);
    bizname= sharedPreferences.getString(BusinessInfo.bizname);
    email1= sharedPreferences.getString(BusinessInfo.email1);
    num1= sharedPreferences.getString(BusinessInfo.num1);
    tax= sharedPreferences.getString(BusinessInfo.tax);
    tin= sharedPreferences.getString(BusinessInfo.tin);
    add = sharedPreferences.getString(BusinessInfo.add);
    time = sharedPreferences.getString(BusinessInfo.time);
    sta= sharedPreferences.getString(BusinessInfo.sta);
    serve= sharedPreferences.getString(BusinessInfo.serve);
  }


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
    getBusiness();


    super.initState();
  }



  @override
  Widget build(BuildContext context) {




    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [

                Center(
                  child: SizedBox(
                    height:80 ,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl:widget.logo,
                        // imageUrl:'https://bodayo.000webhostapp.com/api/owner/logo/${biz[index]['logo']}',
                        placeholder: (context,url)=>Container(
                          height: 80,
                          width: 80,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),

                  ),
                ),

                const SizedBox(height: 10,),

                Text(widget.biz,style: const TextStyle(fontSize: 22),),

                const Text('Your  Registration sent to the GarageYo Admin \n Admin will contact you soon..',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),),

              ],

            ),
          ],
        ),
      ),
    );
  }


}

