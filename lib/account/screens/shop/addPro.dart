import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:garageyo_owner/account/provider/shop.dart';
import 'package:garageyo_owner/pref/buz.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../custom_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AddProduct extends StatefulWidget {
  static const  String id='addproduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final _kate=TextEditingController();
  final _name=TextEditingController();
  final _desc=TextEditingController();
  final _priceO=TextEditingController();
  final _priceC=TextEditingController();
  final _brand=TextEditingController();
  final _sk=TextEditingController();
  final _kg=TextEditingController();
  final _tax=TextEditingController();
  final _col=TextEditingController();
  final _invQty=TextEditingController();
  final _inQtyLo=TextEditingController();



  String? proName;
  String? proDesc;
  String? proPC;
  String? proPO;
  String? proBrand;
  String? proSk;
  String? proCate;
  String? proKg;
  String? proTax;
  String? stockQty;
  String? stockQtyLo;

  XFile? _proImage;
  final ImagePicker _picker=ImagePicker();

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }


  final _fomkey=GlobalKey<FormState>();

     final List<String?> _collections=[
    'Featured Products',
    'Best Selling Products',
    'Recently Added'

  ];

    String? dropDownValue;

    bool? _track=false;

  @override
  void initState() {
    getPref();
    getBusiness();
    showCat();
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


  Future savePro() async {
    var request=http.MultipartRequest('Post',Uri.parse('https://mymusawoe.000webhostapp.com/api/owner/addPro.php'));
    request.fields['user_id']='$user_id';

    var photo = await http.MultipartFile.fromPath('shop', _proImage!.path);
    request.files.add(photo);


    request.fields['ownerName']='$name';
    request.fields['shopName']='$bizname';
    request.fields['productName']=_name.text;
    request.fields['descc']=_desc.text;
    request.fields['price']=_priceC.text;
    request.fields['compared']=_priceO.text;
    request.fields['collection']=_col.text;
    request.fields['brand']=_brand.text;
    request.fields['category']=_kate.text;
    request.fields['weight']=_kg.text;
    request.fields['tax']=_tax.text;






    var response=await request.send();

    if(response.statusCode==200){



      showDialog(
        context: (context),
        builder:(context)=> AlertDialog(
          title:const Text('Message'),
          content:const Text('Product Saved..') ,
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
          content:const Text('Product failed to save.') ,
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


  late List cat = [];
  Future showCat() async {
    var response = await http.post(
        Uri.parse("https://mymusawoe.000webhostapp.com/api/owner/duka/shop.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        cat = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }

  @override
  Widget build(BuildContext context) {

    var _shopPro=Provider.of<ShopProvider>(context);



    Widget _appBar(title,fieldValue){

      return  AppBar(
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
        automaticallyImplyLeading: false,
        title: Text('$title>$fieldValue',style: TextStyle(color: Colors.white,fontSize: 14),),
      );
    }



    Widget _listview({fieldValue,list,textController}){

      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar('Spare','Collections'),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder:(BuildContext context, int index){
                    return ListTile(
                      onTap: (){
                        textController.text=list[index];
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



    Widget _category(){

      return  Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Spare ','Categories'),

            Expanded(
              child: FutureBuilder(
                future: showCat(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:cat.length ,
                      itemBuilder:(context,index){

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:NetworkImage(
                                'https://mymusawoe.000webhostapp.com/admin/ajax/shop/${cat[index]['pic']}',
                            ) ,
                          ),

                          onTap: (){

                            setState(() {
                              _kate.text=cat[index]['title'];
                            });
                            Navigator.pop(context);

                          },
                          title: Text(cat[index]['title'],style:const TextStyle(fontSize:15,color: Colors.black),),
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
        title: const Text('Add Products ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
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
                        child: const Text('Products/Add'),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightBlue,
                      child:const Text('Save',style: TextStyle(color: Colors.white),),
                      onPressed:(){

                        if(_proImage==null){
                          _scaffold('Product Image not Selected');
                          return;

                        }


                        if(_fomkey.currentState!.validate()){
                          EasyLoading.show(status: 'Saving Product.......');

                           savePro();


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
                              controller:_name,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Name';
                                }

                                setState(() {
                                  proName=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(


                                labelText: 'Product Name*',
                                labelStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  )
                                )
                              ),
                            ),

                            TextFormField(
                              keyboardType:TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 500,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Description';
                                }

                                setState(() {
                                  proDesc=value;
                                });
                                return null;
                              },

                              controller:_desc,
                              decoration: InputDecoration(
                                  labelText: 'Product Description*',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),


                             //try
                            _proImage==null ?
                            Container(
                                color: Colors.lightBlue,
                                height: 150,
                                width: 150,
                                child: TextButton(
                                  child:const Center(
                                    child: Text('Tap to add Product Image',style: TextStyle(color:Colors.white ),
                                    ),
                                  ),
                                  onPressed: ()
                                  {
                                    _pickImage().then((value){
                                      setState(() {
                                        _proImage=value;
                                      });
                                    });

                                  },
                                )
                            ): InkWell(
                              onTap: ()
                              {
                                _pickImage().then((value){
                                  setState(() {
                                    _proImage=value;
                                  });
                                });

                              },
                              child: Container(
                                height: 150,
                                width: 150,

                                decoration:BoxDecoration(
                                  color: Colors.lightBlue,
                                  image:DecorationImage(

                                      image:FileImage(File(_proImage!.path),),
                                      fit: BoxFit.cover

                                  ),

                                ),
                              ),
                            ),


                             //failed
                            //  InkWell(
                            //    onTap: (){
                            //
                            //      _pickImage().then((value){
                            //        setState(() {
                            //          _proImage=value;
                            //        });
                            //      });
                            //
                            //    },
                            //    child:  Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child:  _proImage==null ? const SizedBox(
                            //       height: 150,
                            //       width:150,
                            //       child: Card(
                            //         child: Center(
                            //           child: Text('Product Image*'),
                            //         ),
                            //       ),
                            //     ): SizedBox(
                            //       height: 150,
                            //       width:150,
                            //       child: Card(
                            //         child:Container(
                            //             decoration:BoxDecoration(
                            //               color: Colors.lightBlue,
                            //               image:DecorationImage(
                            //
                            //                   image:FileImage(File(_proImage!.path),),
                            //                   fit: BoxFit.cover
                            //
                            //               ),
                            //
                            //             )
                            //         ),
                            //
                            //       ),
                            //     ),
                            // ),
                            //  ),


                            TextFormField(
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Price';
                                }

                                setState(() {
                                  proPC=value;
                                });
                                return null;
                              },

                              controller:_priceC,
                              keyboardType:TextInputType.number,
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
                              validator: (value){
                                //not compulsary

                                if(value!.isEmpty){//always compared price should be higher
                                  return 'Compared Price should be higher than price';
                                }

                                setState(() {
                                  proPO=value;
                                });
                                return null;
                              },

                              controller:_priceO,
                              keyboardType:TextInputType.number,
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


                            TextFormField(
                              controller:_brand,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Brand';
                                }

                                setState(() {
                                  proBrand=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Brand',
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

                                return _category();
                                });

                              },
                              child: TextFormField(
                                controller:_kate,
                                  enabled: false,
                                validator: (value){
                                  if(value!.isEmpty){

                                    return 'Enter Product Category';
                                  }

                                  setState(() {
                                    proCate=value;
                                  });
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Category',
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
                              controller:_kg,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter Product Measurement';
                                }

                                setState(() {
                                  proKg=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Weight e.g kg,gm litrs ,etc',
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      )
                                  )
                              ),
                            ),


                            TextFormField(
                              controller:_tax,
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if(value!.isEmpty){

                                  return 'Enter  Tax%';
                                }

                                setState(() {
                                  proTax=value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Tax%',
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
