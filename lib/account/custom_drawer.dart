
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/screens/account/account.dart';
import 'package:garageyo_owner/account/screens/account/business.dart';
import 'package:garageyo_owner/account/screens/garage/garage.dart';
import 'package:garageyo_owner/account/screens/banner.dart';
import 'package:garageyo_owner/account/screens/shop/addPro.dart';
import 'package:garageyo_owner/account/screens/shop/product.dart';
import 'package:garageyo_owner/account/screens/washingbay/addWash.dart';
import 'package:garageyo_owner/account/screens/washingbay/adpa.dart';
import 'package:garageyo_owner/account/screens/washingbay/viewpa.dart';
import 'package:garageyo_owner/account/screens/washingbay/wash.dart';
import 'package:garageyo_owner/login/login.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:garageyo_owner/account/screens/garage/addGarage.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


class CustomD extends StatefulWidget {

  const CustomD({Key? key}) : super(key: key);

  @override
  _CustomDState createState() => _CustomDState();
}

class _CustomDState extends State<CustomD> {
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
    getBusiness();

    showBiz();
    super.initState();
  }

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


    Widget _menu({String? menuTitle, IconData? icon,String? route}){
      return ListTile(
        leading: Icon(icon),
        title: Text(menuTitle!),
        onTap: (){
          Navigator.pushReplacementNamed(context,route!);
        },

      );
    }


    return Drawer(
      backgroundColor: Colors.white,

      child: Column(
        children: [

      Container(
        height: 160,
        color:Theme.of(context).primaryColor,
        child: Row(
          children: [
            DrawerHeader(
              child:
              Row(
                children: [


                  Center(child: Text('$bizname',overflow:TextOverflow.ellipsis,
                      style:const TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),)),
                ],
              ),
            ),

          ],
        ),
      ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [


                _menu(
                  icon:Icons.dashboard_outlined,
                  menuTitle:'Home',
                  route:HomeScreen.id,
                ),


                if('$serve'=='Spare Parts & Shop')
                ExpansionTile(
                  leading: const Icon(Icons.shopping_bag_outlined),
                    title:const Text('Products'),
                  children: [

                    _menu(
                      menuTitle:'All Products',
                      route:ProductsScreen.id,
                    ),


                    _menu(
                      menuTitle:'Add Product',
                      route:AddProduct.id,
                    ),


                  ],
                ),





                if('$serve'=='Washing Bays')
                ExpansionTile(
                  leading: const Icon(CupertinoIcons.car_detailed),
                  title:const Text('WashingBay Services'),
                  children: [

                    _menu(
                      menuTitle:'All Washing Bay Services',
                      route:WashingBay.id,
                    ),

                    _menu(
                      menuTitle:'All Washing Bay Packages',
                      route:ViewPack.id,
                    ),

                    _menu(
                      menuTitle:'Add Bay Service',
                      route:AddWash.id,
                    ),

                    _menu(
                      menuTitle:'Add Bay Package',
                      route:AddPackage.id,
                    ),


                  ],
                ),



                if('$serve'=='Garages')
                  ExpansionTile(
                    leading: const Icon(CupertinoIcons.car_detailed),
                    title:const Text('Garage Services'),
                    children: [

                      _menu(
                        menuTitle:'All Garage Services',
                        route:Garage.id,
                      ),


                      _menu(
                        menuTitle:'Add Garage Service',
                        route:addGarage.id,
                      ),


                    ],
                  ),



                ExpansionTile(
                  leading: const Icon(CupertinoIcons.person),
                  title:const Text('Account'),
                  children: [

                    _menu(
                      menuTitle:'Edit Account',
                      route:EditAccount.id,
                    ),


                    _menu(
                      menuTitle:'Edit Business',
                      route:EditBusiness.id,
                    ),


                  ],
                ),


                _menu(
                  icon:CupertinoIcons.photo,
                  menuTitle:'Banners',
                  route:Banners.id,
                ),




                _menu(
                  icon:Icons.notifications_outlined,
                  menuTitle:'Notifications',
                  route:HomeScreen.id,
                ),



                _menu(
                  icon:CupertinoIcons.gift,
                  menuTitle:'Coupons',
                  route:HomeScreen.id,
                ),

                _menu(
                  icon:Icons.list_alt_outlined,
                  menuTitle:'Orders',
                  route:HomeScreen.id,
                ),



                _menu(
                  icon:Icons.stacked_bar_chart_outlined,
                  menuTitle:'Reports',
                  route:HomeScreen.id,
                ),


                _menu(
                  icon:Icons.settings_outlined,
                  menuTitle:'Settings',
                  route:HomeScreen.id,
                ),

                _menu(
                  icon:Icons.arrow_back_ios,
                  menuTitle:'LogOut',
                  route:HomeScreen.id,
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}
