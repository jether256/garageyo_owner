import 'package:flutter/material.dart';
import 'package:garageyo_owner/account/screens/shop/publishedpro.dart';
import 'package:garageyo_owner/account/screens/shop/unpublishedpro.dart';


import '../../custom_drawer.dart';
import 'addPro.dart';


class ProductsScreen extends StatefulWidget {

  static const  String id='product';
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          elevation: 0,
        ),
        drawer: CustomD(),
        body:Column(
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
                        child: Row(
                          children: const [
                            Text('Products'),
                          SizedBox(width:10),
                            CircleAvatar(
                              backgroundColor: Colors.black54,
                              maxRadius: 8,
                              child: FittedBox(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('20',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                          ],

                        ),
                      ),
                    ),

                    MaterialButton(
                      color:Colors.lightBlue,
                      child:const Text('Add',style: TextStyle(color: Colors.white),),
                        onPressed:(){
                          Navigator.pushReplacementNamed(context,AddProduct.id);
                        },
                    ),
                  ],
                ),
              ),
            ),
            const TabBar(
              indicatorColor: Colors.lightBlue,
                labelColor: Colors.lightBlue,
                unselectedLabelColor: Colors.grey,
                tabs:[
                  Tab(text: 'Published',),
                  Tab(text: 'unpublished',),


                ]
            ),

              Expanded(
               child: TabBarView(
                 physics: BouncingScrollPhysics(),
                  children:[
                    PublisehdPro(),
                 UnpublishedPro(),
                  ]
            ),
             ),
          ],
        ),
      ),
    );
  }
}
