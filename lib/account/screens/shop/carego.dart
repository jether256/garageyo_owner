import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/provider/shop.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({Key? key}) : super(key: key);

  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {




  @override
  void initState() {

    showCat();
    super.initState();
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
    return Dialog(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Category',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
            future:showCat(),
            builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){

              if (snapshot.hasData) {

                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:cat.length ,
                      itemBuilder:(context,index){


                        return Waaa(
                          saID:cat[index]['id'],
                          saTitle:cat[index]['title'],
                          saPic:'https://mymusawoe.000webhostapp.com/admin/ajax/shop/${cat[index]['pic']}',

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

    var _shopPro=Provider.of< ShopProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:NetworkImage(
          widget.saPic,
        ) ,
      ),
      title: Text(widget.saTitle),
      onTap: (){

        _shopPro.selectedKat(widget.saTitle);
        Navigator.pop(context);
      },
    );
  }
}
