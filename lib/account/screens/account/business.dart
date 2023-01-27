import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../custom_drawer.dart';


class EditBusiness extends StatefulWidget {
  static const  String id='editBiz';

  @override
  _EditBusinessState createState() => _EditBusinessState();
}

class _EditBusinessState extends State<EditBusiness> {
  final _fomkey=GlobalKey<FormState>();


  final _name=TextEditingController();
  final _bizNem=TextEditingController();
  final _phone=TextEditingController();
  final _mail=TextEditingController();
  final _tin=TextEditingController();
  final _addressController=TextEditingController();
  final _tipo=TextEditingController();

  @override
  void initState() {
    getPref();
    showAdu();
    showType();
    getBusiness();
    getProducts();
    super.initState();
  }

  getProducts() async{



    setState(() {
      _name.text='$name';
      _bizNem.text='$bizname';
      _phone.text='$num1';
      _mail.text='$email1';
      _tin.text='$tin';
      _addressController.text='$add';
      _tipo.text='$serve';


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




  late List adu = [];
  Future showAdu() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/loc.php"),
        headers: {"Accept": "headers/json"},body:{'id':'$userID'});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        adu = jsonData;
      });
      print(jsonData);
      return jsonData;
    }
  }

  late List type1 = [];
  Future showType() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/service.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        type1 = jsonData;
      });
      print(jsonData);
      return jsonData;
    }
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


  save() async {

    var response=await http.post(Uri.parse('https://bodayo.000webhostapp.com/api/owner/editBusiness.php'),

        body:{
          "bizname":_bizNem.text,
          "email1":_mail.text,
          "phone1":_phone.text,
          "address":_addressController.text,
          "tin":_tin.text,
          "service":_tipo.text,
          "user_id":'$userID',
        });



    if(response.statusCode==200){



      showDialog(
        context: (context),
        builder:(context)=> AlertDialog(
          title:const Text('Message'),
          content:const Text('Account Edited..') ,
          actions:<Widget> [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Colors.lightBlue),
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
          content:const Text('Account failed to edit.') ,
          actions:<Widget> [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Colors.lightBlue),
              ),
              onPressed:(){
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



    Widget _appBar(title,fieldValue){

      return  AppBar(
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        automaticallyImplyLeading: false,
        title: Text('$title>$fieldValue',style: const TextStyle(color: Colors.black,fontSize: 14),),
      );
    }


    Widget _add(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Business','Address'),

            FutureBuilder(
              future:showAdu(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:adu.length ,
                    itemBuilder:(context,index){

                      return ListTile(
                        onTap: (){

                          setState(() {
                            _addressController.text=adu[index]['address'];
                          });
                          Navigator.pop(context);

                        },
                        title: Text(adu[index]['address'],style:const TextStyle(fontSize:15,color: Colors.black),),
                      );


                    });
              },
            ),
          ],

        ),
      );


    }


    Widget _type(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Business','Type'),

            FutureBuilder(
              future:showType() ,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:type1.length ,
                    itemBuilder:(context,index){

                      return ListTile(
                        onTap: (){

                          setState(() {
                            _tipo.text=type1[index]['name'];
                          });
                          Navigator.pop(context);

                        },
                        title: Text(type1[index]['name'],style:const TextStyle(fontSize:15,color: Colors.black),),
                      );


                    });
              },
            ),
          ],

        ),
      );


    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Business ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      drawer: CustomD(),
      body: Form(
        key: _fomkey,
        child: Column(
          children: [
            Material(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        child: const Text('Edit Business Account'),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightBlue,
                      child:const Text('Edit',style: TextStyle(color: Colors.white),),
                      onPressed:(){



                        if(_fomkey.currentState!.validate()){
                          EasyLoading.show(status: 'Saving Service.......');

                          save();

                          EasyLoading.dismiss();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey.shade100,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [



                            TextFormField(
                              controller: _bizNem,
                              keyboardType:TextInputType.text,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Business Name';
                                }

                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Business Name*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),

                            TextFormField(
                              controller: _phone,
                              keyboardType:TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Phone Number';
                                }

                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Phone*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),

                            TextFormField(
                              controller: _mail,
                              keyboardType:TextInputType.emailAddress,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Email';
                                }

                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Email*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),

                            TextFormField(
                              controller: _tin,
                              keyboardType:TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Tin Number';
                                }

                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Phone*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),

                            InkWell(
                              onTap: (){

                                //lets show the list of cars instead of manually typing
                                showDialog(context: context,builder: (BuildContext context){

                                  return _add();
                                });
                              },
                              child: TextFormField(
                                controller: _addressController,
                                maxLines: 4,
                                minLines: 2,
                                enabled: false,//enter manually now

                                decoration:const InputDecoration(
                                  labelText: 'Address',
                                  counterText: 'SellerAddress',
                                ),

                                validator: (value){

                                  if(value!.isEmpty){
                                    return 'Please complete required field';
                                  }
                                  return null;
                                },

                              ),
                            ),

                            const SizedBox(height: 10,),

                            InkWell(
                              onTap: (){

                                //lets show the list of cars instead of manually typing
                                showDialog(context: context,builder: (BuildContext context){

                                  return _type();
                                });
                              },
                              child: TextFormField(
                                controller: _tipo,
                                maxLines: 4,
                                minLines: 2,
                                enabled: false,//enter manually now

                                decoration:const InputDecoration(
                                  labelText: 'Service',
                                  counterText: 'Services',
                                ),

                                validator: (value){

                                  if(value!.isEmpty){
                                    return 'Please complete enter a Service';
                                  }
                                  return null;
                                },

                              ),
                            ),
                            const Divider(color: Colors.grey,),







                          ],
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
