import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/account/provider/auth.dart';
import 'package:garageyo_owner/account/provider/proid.dart';
import 'package:garageyo_owner/account/screens/account/account.dart';
import 'package:garageyo_owner/account/screens/account/business.dart';
import 'package:garageyo_owner/account/screens/banner.dart';
import 'package:garageyo_owner/account/screens/garage/editgal.dart';
import 'package:garageyo_owner/account/screens/garage/publishedgal.dart';
import 'package:garageyo_owner/account/screens/garage/unpublishedgal.dart';
import 'package:garageyo_owner/account/screens/shop/EditViewPro.dart';
import 'package:garageyo_owner/account/screens/shop/publishedpro.dart';
import 'package:garageyo_owner/account/screens/shop/unpublishedpro.dart';
import 'package:garageyo_owner/account/screens/washingbay/adpa.dart';
import 'package:garageyo_owner/account/screens/washingbay/editbay.dart';
import 'package:garageyo_owner/account/screens/washingbay/publishedbay.dart';
import 'package:garageyo_owner/account/screens/washingbay/unpublishedbay.dart';
import 'package:garageyo_owner/account/screens/washingbay/viewpa.dart';
import 'package:garageyo_owner/splash.dart';
import 'package:garageyo_owner/wait.dart';

import 'package:provider/provider.dart';

import 'Provider/locationPro.dart';
import 'account/home.dart';
import 'account/provider/garap.dart';
import 'account/provider/shop.dart';
import 'account/provider/typepro.dart';
import 'account/provider/vendPro.dart';
import 'account/provider/washPack.dart';
import 'account/provider/washPro.dart';
import 'account/screens/garage/addGarage.dart';
import 'account/screens/garage/garage.dart';
import 'account/screens/shop/addPro.dart';
import 'account/screens/shop/product.dart';
import 'account/screens/washingbay/addWash.dart';
import 'account/screens/washingbay/wash.dart';
import 'location.dart';
import 'login/linda.dart';
import 'login/login.dart';
import 'login/reg.dart';
import 'login/regsiter.dart';
import 'map/map.dart';


void main() async{

  Provider.debugCheckInvalidValueType=null;
  runApp(

    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create:(_) => AuthProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => LocationProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => BusinessProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => WashServiceProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => WashPackProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => typeProvider(),
        ),


        ChangeNotifierProvider(
          create:(_) => GaraProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ShopProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ProductIDProvider(),
        ),


      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garage yo',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          fontFamily: 'Gothic'
      ),
      builder:EasyLoading.init(),
      initialRoute: Splash.id,// first route
      routes: {
        //we will add the screens here for easy navigation
        Splash.id:(context)=>Splash(),
        LoginForm.id:(context)=>LoginForm(),
        Register.id:(context)=>Register(),
        Wait.id:(context)=>Wait(),
        Reg.id:(context)=>Reg(),
        locationL.id:(context)=>locationL(),
        Mapma.id:(context)=>Mapma(),
        linda.id:(context)=>linda(),
        HomeScreen.id:(context)=>HomeScreen(),
        ProductsScreen.id:(context)=>ProductsScreen(),
        AddProduct.id:(context)=>AddProduct(),
        AddWash.id:(context)=>AddWash(),
        WashingBay.id:(context)=>WashingBay(),
        addGarage.id:(context)=>addGarage(),
        Garage.id:(context)=>Garage(),
        PublisehdPro.id:(context)=>PublisehdPro(),
        UnpublishedPro.id:(context)=>UnpublishedPro(),
        PublishedGara.id:(context)=>PublishedGara(),
        UnpublishedGara.id:(context)=>UnpublishedGara(),
        PublishedBay.id:(context)=>PublishedBay(),
        Unpublishedbay.id:(context)=>Unpublishedbay(),

        EditViewBay.id:(context)=>EditViewBay(),
        EditViewGal.id:(context)=>EditViewGal(),
        Banners.id:(context)=>Banners(),
        AddPackage.id:(context)=>AddPackage(),
        ViewPack.id:(context)=>ViewPack(),
        EditAccount.id:(context)=>EditAccount(),
        EditBusiness.id:(context)=>EditBusiness(),

      },
    );
  }
}

