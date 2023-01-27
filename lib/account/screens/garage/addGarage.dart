import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/account/provider/garap.dart';
import 'package:garageyo_owner/account/provider/typepro.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'type.dart';
import '../../custom_drawer.dart';

class addGarage extends StatefulWidget {
  static const  String id='addGa';

  @override
  _addGarageState createState() => _addGarageState();
}

class _addGarageState extends State<addGarage> {



  final _type=TextEditingController();
  final _service=TextEditingController();
  final _priceO=TextEditingController();
  final _priceC=TextEditingController();
  final _col=TextEditingController();




  final _fomkey=GlobalKey<FormState>();

  final List<String?> _collections=[
    'Featured Products',
    'Best Selling Products',
    'Recently Added'

  ];



  bool? _track=false;

  @override
  void initState() {
    getPref();
    getBusiness();
    showService();

    showType();
    super.initState();
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



  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'Ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }


  save() async {

    var response=await http.post(Uri.parse('https://bodayo.000webhostapp.com/api/owner/garage/addService.php'),

        body:{"price":_priceC.text,
          "shopName":'$bizname',
          "ownerName":'$name',
          "service":_service.text,
          "compared":_priceO.text,
          "user_id":'$user_id',
          "carType":_type.text,
          "collection":_col.text,

        });


    if(response.statusCode==200){



      showDialog(
        context: (context),
        builder:(context)=> AlertDialog(
          title:const Text('Message'),
          content:const Text('Service Saved..') ,
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
          content:const Text('Service failed to save.') ,
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


  late List sir = [];
  Future showService() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/garage/garas.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        sir = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }




  late List car = [];
  Future showType() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/type.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        car = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }



  @override
  Widget build(BuildContext context) {

    Widget _appBar(title, fieldValue) {
      return AppBar(
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        automaticallyImplyLeading: false,
        title: Text('$title>$fieldValue',
          style: TextStyle(color: Colors.white, fontSize: 14),),
      );
    }


    Widget _listview({fieldValue, list, textController}) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar('Spare', 'Collections'),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        textController.text = list[index];
                        Navigator.pop(context);
                      },


                      title: Text(list[index]),

                    );
                  }),
            )
          ],
        ),
      );
    }


    Widget _carType() {
      return Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Car ', 'Car Type'),

            Expanded(
              child: FutureBuilder(
                future: showType(),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: car.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://bodayo.000webhostapp.com/admin/ajax/type/${car[index]['pic']}',
                            ),
                          ),

                          onTap: () {
                            setState(() {
                              _type.text = car[index]['type'];
                            });
                            Navigator.pop(context);
                          },
                          title: Text(
                            car[index]['type'], style: const TextStyle(
                              fontSize: 15, color: Colors.black),),
                        );
                      });
                },
              ),
            ),
          ],

        ),
      );
    }


    Widget _carService() {
      return Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Spare ', 'Services'),

            Expanded(
              child: FutureBuilder(
                future: showService(),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: sir.length,
                      itemBuilder: (context, index) {
                        return ListTile(

                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://bodayo.000webhostapp.com/admin/ajax/gal/${sir[index]['pic']}',
                            ),
                          ),

                          onTap: () {
                            setState(() {
                              _service.text = sir[index]['service'];
                            });
                            Navigator.pop(context);
                          },
                          title: Text(
                            sir[index]['service'], style: const TextStyle(
                              fontSize: 15, color: Colors.black),),
                        );
                      });
                },
              ),
            ),
          ],

        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Garage ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                        child: const Text(' Garage Services/Add'),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightBlue,
                      child:const Text('Save',style: TextStyle(color: Colors.white),),
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


                            InkWell(
                              onTap: (){
                                //lets show the list of cars instead of manually typing
                                showDialog(context: context,builder: (BuildContext context){

                                  return _carType();
                                });

                              },
                              child: TextFormField(
                                controller:_type,
                                enabled: false,
                                validator: (value){
                                  if(value!.isEmpty){

                                    return 'Enter Car Type';
                                  }


                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Car Type',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        )
                                    )
                                ),
                              ),
                            ),


                            InkWell(
                              onTap: (){
                                //lets show the list of cars instead of manually typing
                                showDialog(context: context,builder: (BuildContext context){

                                  return _carService();
                                });

                              },
                              child: TextFormField(
                                controller:_service,
                                enabled: false,
                                validator: (value){
                                  if(value!.isEmpty){

                                    return 'Enter Service';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Service',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        )
                                    )
                                ),
                              ),
                            ),






                            TextFormField(
                              controller: _priceC,
                              keyboardType:TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Service Price';
                                }

                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Price*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),


                            TextFormField(
                              controller: _priceO,
                              keyboardType:TextInputType.number,
                              validator: (value){
                                //not compulsary

                                if(value!.isEmpty){//always compared price should be higher
                                  return 'Compared Price should be higher than price';
                                }


                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Compared Price*',//Price before discount
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

                                showDialog(context: context, builder:(BuildContext context){
                                  return _listview(fieldValue: 'Collections',list: _collections,textController: _col);

                                });
                              },
                              child: TextFormField(
                                controller: _col,

                                enabled: false,//enter manually now

                                decoration:const InputDecoration(
                                  labelText: 'Collection',
                                  counterText: 'Collection',
                                ),

                                validator: (value){

                                  if(value!.isEmpty){
                                    return 'Please Enter Collection';
                                  }
                                  return null;
                                },

                              ),
                            ),





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
