import 'package:flutter/material.dart';


class SubCat extends StatefulWidget {
  const SubCat({Key? key}) : super(key: key);

  @override
  _SubCatState createState() => _SubCatState();
}

class _SubCatState extends State<SubCat> {
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
                const Text('Select SubCategory',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                IconButton(
                    onPressed:(){
                      Navigator.pop(context);
                    },
                    icon:const Icon(Icons.close,color: Colors.white,)
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
