// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:forum_republique/adherants_screen/deleteadherants.dart';
// import 'package:forum_republique/adherants_screen/updateadherants.dart';
// import 'package:forum_republique/adherants_screen/user.dart';
// import 'package:forum_republique/models/AdherantsModel.dart';
//
// import 'package:http/http.dart' as http;
//
// class getadherants extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState(){
//     return getAllAdherants();
//   }
// }
// class getAllAdherants extends State<getadherants>{
//   var adherants = List<User>.generate(200, (index) => null!);
//
//   Future<List<User>> getadherants () async{
//     final data = await http.get(Uri.parse('http://localhost:8090/api/v1/users/findUserDto'));
//     var jsonData = json.decode(data.body);
//
//     List<User> adherant =[];
//     for (var e in jsonData){
//       adherants.id =e["id"];
//       adherants.firstName = e["firstName"];
//       adherants.lastName = e["lastName"];
//       adherants.add(adherants);
//     }
//     return adherant;
//   }
//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     appBar :new AppBar(
//       title: new Text("All Adherants Details"),
//       leading : IconButton(
//         icon: Icon(
//           Icons.arrow_back
//         ), onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
//
//       },
//       ) ,
//     ),
//     body: Container(
//       child: FutureBuilder(
//         future: getadherants(),
//         builder: (BuildContext context,AsyncSnapshot snapshot) {
//           if(snapshot.data == null){
//             return Container(child: Center(child: Icon(Icons.error)));
//
//           }
//           return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder:(BuildContext context,int index){
//                 return ListTile(
//                   title: Text(
//                     'ID' + ' ' + 'First Name ' + ' '+ 'Last Name'
//                   ),
//                   subtitle: Text(
//                  '${snapshot.data[index].id}'+
//                   '${snapshot.data[index].firstName}'+
//                   '${snapshot.data[index].lastName}'
//                   ),
//                   onTap: (){
//                     Navigator.push(context,MaterialPageRoute(builder:(context)=> DetailPage(snapshot.data[index])));
//                   },
//                 );
//               });
//         },
//
//       ),
//     ),
//     );
//   }
//
// }
// class DetailPage extends StatelessWidget{
//   late AdherantsModel adherant ;
//     DetailPage (this.adherant , {Key? key}) : super(key: key);
//     deleteAdherant1(AdherantsModel adherant) async{
//       final url=Uri.parse('http://localhost:8080/deleteAderants');
//       final request = http.Request("DELETE",url);
//       request.headers.addAll(<String ,String>{
//         "Content-type" : "application/json"
//       });
//       request.body =jsonEncode(adherant);
//       final response = await request.send();
//     }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         title: Text(adherant.firstName),actions:<Widget> [
//           IconButton(icon: Icon(
//             Icons.edit,
//             color: Colors.white,
//           ),
//           onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=> updateAdherants()));
//           }),
//       ],
//       ) ,
//       body: Container(
//         child: Text('FirstName'+ ' ' + adherant.firstname + ' '+ 'LastName'+ adherant.lastName),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           deleteAdherant1(adherant);
//           Navigator.push(context, MaterialPageRoute(builder: (context) => deleteAdherants()));
//         },
//         child:Icon(Icons.delete),
//         backgroundColor: Colors.red,
//       ),
//     );
//
//   }
// }