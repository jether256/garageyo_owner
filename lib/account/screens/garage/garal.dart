import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/provider/garap.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class GaraList extends StatefulWidget {
  const GaraList({Key? key}) : super(key: key);

  @override
  _GaraListState createState() => _GaraListState();
}

class _GaraListState extends State<GaraList> {

  @override
  void initState() {

    showGara();
    super.initState();
  }

  late List gara = [];
  Future showGara() async {
    var response = await http.post(
        Uri.parse("https://bodayo.000webhostapp.com/api/owner/garage/garas.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);


      setState(() {
        gara = jsonData;

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
                const Text('Select Service',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
            future:showGara(),
            builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){

              if (snapshot.hasData) {

                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:gara.length ,
                      itemBuilder:(context,index){


                        return Waaa(
                          saID:gara[index]['id'],
                          saTitle:gara[index]['service'],
                          saPic:'https://bodayo.000webhostapp.com/admin/ajax/gal/${gara[index]['pic']}',

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

    var _garaPro=Provider.of<GaraProvider>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:NetworkImage(
          widget.saPic,
        ) ,
      ),
      title: Text(widget.saTitle),
      onTap: (){

        _garaPro.selectedGal(widget.saTitle);
        Navigator.pop(context);
      },
    );
  }
}
