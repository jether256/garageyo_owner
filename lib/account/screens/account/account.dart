import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../custom_drawer.dart';


class EditAccount extends StatefulWidget {
  static const  String id='editAca';


  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _fomkey=GlobalKey<FormState>();


  final _name=TextEditingController();
  final _phone=TextEditingController();
  final _mail=TextEditingController();

  @override
  void initState() {
    getPref();
    getProducts();
    super.initState();
  }

  getProducts() async{



    setState(() {
      _name.text='$name';
      _phone.text='$num';
      _mail.text='$email';


    });


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

    var response=await http.post(Uri.parse('https://bodayo.000webhostapp.com/api/owner/editAccount.php'),

        body:{
          "name":_name.text,
          "email":_mail.text,
          "phone":_phone.text,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                        child: const Text('Edit Account'),
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
                              controller: _name,
                              keyboardType:TextInputType.text,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Name';
                                }

                                return null;
                              },
                              decoration: InputDecoration(

                                  labelText: 'Name*',
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
