import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/account/screens/bancard.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../custom_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Banners extends StatefulWidget {
  static const  String id='banner';

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {

  late bool _visible = false;

  final ImagePicker _picker = ImagePicker();

  XFile? _shopBanner;
  final _title = TextEditingController();

  final _fomkey = GlobalKey<FormState>();

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    return image;
  }

  _scaffold(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
      action: SnackBarAction(label: 'Ok', onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }

  @override
  void initState() {
    getPref();
    getBusiness();

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


  Future savePro() async {
    var request = http.MultipartRequest('Post',
        Uri.parse('https://bodayo.000webhostapp.com/api/owner/addBana.php'));
    request.fields['user_id'] = '$user_id';
    var photo = await http.MultipartFile.fromPath('shop', _shopBanner!.path);
    request.files.add(photo);
    request.fields['ownerName'] = '$name';
    request.fields['shopName'] = '$bizname';
    request.fields['title'] = _title.text;


    var response = await request.send();


    if (response.statusCode == 200) {
      showDialog(
        context: (context),
        builder: (context) =>
            AlertDialog(
              title: const Text('Message'),
              content: const Text('Banner Saved..'),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.deepOrangeAccent),
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
              content: const Text('Banner failed to save'),
              actions: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.deepOrangeAccent),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Banners ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      drawer: CustomD(),
      body: Form(
        key: _fomkey,
        child: ListView(
          padding: EdgeInsets.zero,
          children:    [
            const  BannerCard(),

            const Divider(thickness: 3,),

            Container(
              child: const Center(child: Text('Add New Banner',style: TextStyle(fontWeight: FontWeight.bold),)),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.grey[200],
                        child:_shopBanner == null ? const Center(child: Text('No Image Selected..')):Container(
                          decoration:BoxDecoration(
                              color:  Colors.grey[200],
                            image:DecorationImage(
                              fit: BoxFit.cover,
                                image:FileImage(File(_shopBanner!.path),),

                            ),
                          ),
                        ),
                      ),

                    ),

                    TextFormField(
                      controller: _title,


                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Visibility(
                      visible: _visible ? false:true,
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              color:Colors.lightBlue,
                              child:const Text('Add new Banner',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              onPressed:(){
                                setState(() {
                                  _visible=true;
                                });

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _visible,
                      child: Container(
                        child: Column(
                         children: [

                           Row(
                             children: [
                               Expanded(
                                 child: MaterialButton(
                                   color:Colors.lightBlue,
                                   child:const Text('Upload Image',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                   onPressed:(){
                                  _pickImage().then((value){


                                      setState(() {

                                          _shopBanner=value;


                                      });
                                  

                                  });
                                   },
                                 ),
                               ),
                             ],
                           ),
                           Row(
                             children: [
                               Expanded(
                                 child: AbsorbPointer(
                                   absorbing:_shopBanner != null ? false:true,
                                   child: MaterialButton(
                                     color:_shopBanner != null ? Colors.lightBlue:Colors.grey,
                                     child:const Text('Save',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                     onPressed:(){

                                       if(_shopBanner==null){
                                         _scaffold('Banner Image not Selected');
                                         return;

                                       }



                                         EasyLoading.show(status: 'Saving Banner..');

                                          savePro();

                                         EasyLoading.dismiss();



                                     },
                                   ),
                                 ),
                               ),
                             ],
                           ),

                           Row(
                             children: [
                               Expanded(
                                 child: MaterialButton(
                                   color:Colors.black54,
                                   child:const Text('Cancel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                   onPressed:(){
                                     setState(() {
                                       _visible=false;
                                     });
                                   },
                                 ),
                               ),
                             ],
                           ),
                         ],
                        ),
                      ),
                    ),



                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
