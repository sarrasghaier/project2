
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/user_screen.dart';


class updateAdherants extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return updateAdherantsState();

  }
}
 class updateAdherantsState extends State<updateAdherants>{
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Update Adherants'),
         leading: IconButton(
           icon: Icon(
               Icons.arrow_back
           ), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
         },
         ),
       ),

     );

   }
 }

