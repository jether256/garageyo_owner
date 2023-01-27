import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/provider/typepro.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';


class Type extends StatefulWidget {
  const Type({Key? key}) : super(key: key);

  @override
  _TypeState createState() => _TypeState();
}

class _TypeState extends State<Type> {


  @override
  void initState() {

    showType();
    super.initState();
  }

  late List type = [];
  Future showType() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/wash/type.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        type = jsonData;

      });

      print(jsonData);
      return jsonData;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select CarType',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                IconButton(
                    onPressed:(){
                      Navigator.pop(context);
                    },
                    icon:const Icon(Icons.close,color: Colors.white,)
                ),
              ],
            ),

          ),
          FutureBuilder(
            future:showType(),
            builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){

              if (snapshot.hasData) {

                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:type.length ,
                      itemBuilder:(context,index){


                        return Waaa(
                          saID:type[index]['ID'],
                          saTitle:type[index]['type'],
                          saPic:'https://bodayo.000webhostapp.com/admin/ajax/type/${type[index]['pic']}',

                        );

                      }),
                );

              }else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

class Waaa extends StatefulWidget {
  final String saID;
  final String saTitle;
  final String saPic;

  Waaa({ required this.saID, required this.saTitle, required this.saPic});


  @override
  _WaaaState createState() => _WaaaState();
}

class _WaaaState extends State<Waaa> {
  @override
  Widget build(BuildContext context) {

    var _carType=Provider.of<typeProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:NetworkImage(
          widget.saPic,
        ) ,
      ),
      title: Text(widget.saTitle),
      onTap: (){

        _carType.selectedCar(widget.saTitle);
        Navigator.pop(context);
      },
    );
  }
}
