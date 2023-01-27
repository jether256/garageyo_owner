
import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:garageyo_owner/account/provider/auth.dart';
import 'package:garageyo_owner/pref/pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:garageyo_owner/login/linda.dart';

class Register extends StatefulWidget {
  static const  String id='register';


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String? countryValue;

  String? stateValue;

  String? cityValue;
  String? address;


  final _formKey = GlobalKey<FormState>();
  final _businessName = TextEditingController();
  final _contNum = TextEditingController();
  final _ema = TextEditingController();
  final _gst = TextEditingController();
  final _pin = TextEditingController();
  final _land = TextEditingController();
  final _city = TextEditingController();
  final _sta = TextEditingController();
  final _tipo = TextEditingController();
  final _addressController = TextEditingController();

  String? _bName;
  String? _taxStatus;
  XFile? _shopName;
  XFile? _log;

  bool visibleLoading = false;

  final ImagePicker _picker = ImagePicker();

  Widget _formField(
      {TextEditingController? controller, String? label, TextInputType? type,
        String? Function(String?)? validator}) {
    return TextFormField(
        controller: controller,
        keyboardType: type,

        decoration: InputDecoration(
          labelText: label,
          prefixText: controller == _contNum ? '+256' : null,


        ),
        validator: validator,

        onChanged: (value) {
          if (controller == _businessName) {
            setState(() {
              _bName = value;
            });
          }
        }

    );
  }

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  _scaffold(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
      action: SnackBarAction(label: 'Ok', onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }


  // Future kola() async {
  //   var request = http.MultipartRequest('Post',
  //       Uri.parse('https://bodayo.000webhostapp.com/api/owner/regB.php'));
  //   request.fields['user_id'] = '$userID';
  //
  //   var photo = await http.MultipartFile.fromPath('logo', _shopName!.path);
  //   request.files.add(photo);
  //
  //   var photo1 = await http.MultipartFile.fromPath('shop', _log!.path);
  //   request.files.add(photo1);
  //   request.fields['bizname'] = _businessName.text;
  //   request.fields['phone'] = '+256${_contNum.text}';
  //   request.fields['email'] = _ema.text;
  //   request.fields['taxRegistered'] = _taxStatus!;
  //   request.fields['tinNumber'] = (_gst.text.isEmpty ? null : _gst.text)!;
  //   request.fields['address'] = _addressController.text;
  //   request.fields['lon'] = '${locationData.longitude}';
  //   request.fields['lat'] = _addressController.text;
  //   request.fields['service'] = _tipo.text;
  //
  //
  //   var response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     Navigator.pushReplacementNamed(context, linda.id);
  //
  //     showDialog(
  //       context: (context),
  //       builder: (context) =>
  //           AlertDialog(
  //             title: const Text('Message'),
  //             content: const Text('Business Registered'),
  //             actions: <Widget>[
  //               ElevatedButton(
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all(
  //                       Colors.deepOrangeAccent),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Cancel'),),
  //
  //             ],
  //           ),
  //     );
  //   } else {
  //     showDialog(
  //       context: (context),
  //       builder: (context) =>
  //           AlertDialog(
  //             title: const Text('Message'),
  //             content: const Text('Business Registration failed..'),
  //             actions: <Widget>[
  //               ElevatedButton(
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all(
  //                       Colors.deepOrangeAccent),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Cancel'),),
  //
  //             ],
  //           ),
  //     );
  //   }
  // }


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
    showAdu();
    showType();
    super.initState();
  }

  late List adu = [];

  Future showAdu() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/loc.php"),
        headers: {"Accept": "headers/json"}, body: {'id': '$userID'});
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
          style: const TextStyle(color: Colors.black, fontSize: 14),),
      );
    }


    Widget _add() {
      return Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Business', 'Address'),

            FutureBuilder(
              future: showAdu(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: adu.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _addressController.text = adu[index]['address'];
                          });
                          Navigator.pop(context);
                        },
                        title: Text(
                          adu[index]['address'], style: const TextStyle(
                            fontSize: 15, color: Colors.black),),
                      );
                    });
              },
            ),
          ],

        ),
      );
    }


    Widget _type() {
      return Dialog(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //going to use it so many times lets create our own app bar
            _appBar('Business', 'Type'),

            FutureBuilder(
              future: showType(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: type1.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _tipo.text = type1[index]['name'];
                          });
                          Navigator.pop(context);
                        },
                        title: Text(
                          type1[index]['name'], style: const TextStyle(
                            fontSize: 15, color: Colors.black),),
                      );
                    });
              },
            ),
          ],

        ),
      );
    }

    final _authData = Provider.of<AuthProvider>(context);


    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Stack(
                  children: [
                    _shopName == null ?
                    Container(
                        color: Colors.lightBlue,
                        height: 240,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: TextButton(
                          child: const Center(
                            child: Text('Tap to add image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _pickImage().then((value) {
                              setState(() {
                                _shopName = value;
                              });
                            });
                          },
                        )
                    ) : InkWell(
                      onTap: () {
                        _pickImage().then((value) {
                          setState(() {
                            _shopName = value;
                          });
                        });
                      },
                      child: Container(
                        height: 240,

                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          image: DecorationImage(
                              opacity: 100,
                              image: FileImage(File(_shopName!.path),),
                              fit: BoxFit.cover

                          ),

                        ),
                      ),
                    ),

                    SizedBox(
                      height: 80,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        actions: [
                          IconButton(

                              onPressed: () {

                              },
                              icon: const Icon(
                                Icons.exit_to_app, color: Colors.white,)),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _pickImage().then((value) {
                                  setState(() {
                                    _log = value;
                                  });
                                });
                              },
                              child: Card(
                                elevation: 4,
                                child: _log == null ? const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(child: Text('+')),
                                ) : ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.file(File(_log!.path)),
                                  ),
                                ),

                              ),
                            ),

                            const SizedBox(width: 10,),

                            Text(
                              _bName == null ? '' : _bName!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),)

                          ],
                        ),
                      ),

                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                child: Column(
                  children: [
                    _formField(
                        controller: _businessName,
                        label: 'Business Name',
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Business Name';
                          }
                        }
                    ),

                    _formField(
                        controller: _contNum,
                        label: 'Contact Number',
                        type: TextInputType.phone,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Contact Number';
                          }
                        }
                    ),

                    _formField(
                        controller: _ema,
                        label: ' Email',
                        type: TextInputType.emailAddress,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          bool _isValid = (EmailValidator.validate(value));
                          if (_isValid == false) {
                            return 'Enter Valid Email Address';
                          }
                        }
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      children: [

                        const Text('Tax Registered:'),

                        Expanded(
                          child: DropdownButtonFormField(
                              value: _taxStatus,
                              validator: (value) {
                                if (value == null) {
                                  return ' Select Tax status';
                                }
                              },
                              hint: const Text('Select'),
                              items: <String>['Yes', 'No']
                                  .map<DropdownMenuItem<String>>((
                                  String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  _taxStatus = value;
                                });
                              }
                          ),
                        ),
                      ],
                    ),

                    if(_taxStatus == "Yes")
                      _formField(
                          controller: _gst,
                          label: 'Tin Number',
                          type: TextInputType.number,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Tin Number';
                            }
                          }
                      ),

                    //
                    // InkWell(
                    //   onTap: () {
                    //     //lets show the list of cars instead of manually typing
                    //     showDialog(
                    //         context: context, builder: (BuildContext context) {
                    //       return _add();
                    //     });
                    //   },
                    //   child: TextFormField(
                    //     controller: _addressController,
                    //     maxLines: 4,
                    //     minLines: 2,
                    //     enabled: false,
                    //     //enter manually now
                    //
                    //     decoration: const InputDecoration(
                    //       labelText: 'Address',
                    //       counterText: 'SellerAddress',
                    //     ),
                    //
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please complete required field';
                    //       }
                    //       return null;
                    //     },
                    //
                    //   ),
                    // ),

                    const SizedBox(height: 10,),

                    InkWell(
                      onTap: () {
                        //lets show the list of cars instead of manually typing
                        showDialog(
                            context: context, builder: (BuildContext context) {
                          return _type();
                        });
                      },
                      child: TextFormField(
                        controller: _tipo,
                        maxLines: 4,
                        minLines: 2,
                        enabled: false,
                        //enter manually now

                        decoration: const InputDecoration(
                          labelText: 'Service',
                          counterText: 'Services',
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please complete enter a Service';
                          }
                          if (_authData.shopLatitude == null) {
                            return 'Please complete enter a Service';
                          }
                          return null;
                        },

                      ),
                    ),
                    const Divider(color: Colors.grey,),


                    InkWell(
                      onTap: () {
                        //lets show the list of cars instead of manually typing
                        _authData.getCurrentAddress().then((address) {
                          if (address != null) {
                            setState(() {
                              _addressController.text =
                              //'${_authData.placeName}\n${_authData.shopAdd}';
                              '${_authData.shopAdd}';
                            });
                          } else {
                            _scaffold('Could not find location try again');
                            return;
                          }
                        });
                      },
                      child: TextFormField(
                        controller: _addressController,
                        maxLines: 4,
                        minLines: 2,
                        enabled: false,
                        //enter manually now

                        decoration: const InputDecoration(
                          labelText: 'Address',
                          counterText: 'SellerAddress',
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please complete required field';
                          }
                          return null;
                        },

                      ),
                    ),





                    const SizedBox(height: 10,),

                  ],

                ),
              ),
            ],
          ),
        ),

        persistentFooterButtons: [

          Row(
            children: [
              Expanded(

                child: ElevatedButton(
                    onPressed: () async {
                      if (_shopName == null) {
                        _scaffold('User Image not Selected');
                        return;
                      }

                      if (_log == null) {
                        _scaffold('Logo Image not Selected');
                        return;
                      }

                      if (_formKey.currentState!.validate()) {


                      }


                      var request = http.MultipartRequest('Post',
                          Uri.parse('https://bodayo.000webhostapp.com/api/owner/regB.php'));
                      request.fields['user_id'] = '$userID';

                      var photo = await http.MultipartFile.fromPath('logo', _shopName!.path);
                      request.files.add(photo);

                      var photo1 = await http.MultipartFile.fromPath('shop', _log!.path);
                      request.files.add(photo1);
                      request.fields['bizname'] = _businessName.text;
                      request.fields['phone'] = '+256${_contNum.text}';
                      request.fields['email'] = _ema.text;
                      request.fields['taxRegistered'] = _taxStatus!;
                      request.fields['tinNumber'] = (_gst.text.isEmpty ? null : _gst.text)!;
                      request.fields['address'] = _addressController.text;
                      request.fields['lon'] = '${_authData.shopLongitude}';
                      request.fields['lat'] = '${_authData.shopLatitude}';
                      request.fields['service'] = _tipo.text;


                      var response = await request.send();

                      if (response.statusCode == 200) {
                        Navigator.pushReplacementNamed(context, linda.id);

                        showDialog(
                          context: (context),
                          builder: (context) =>
                              AlertDialog(
                                title: const Text('Message'),
                                content: const Text('Business Registered'),
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
                                content: const Text('Business Registration failed..'),
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




                    },
                    child: const Text(
                      'Register', style: TextStyle(color: Colors.white),)
                ),
              )

            ],
          ),
        ],
      ),
    );
  }

}



