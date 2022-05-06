import 'package:flutter/material.dart';
import 'package:forum_republique/adherants_screen/user.dart';
import 'package:forum_republique/api/server_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../theme/theme_colors.dart';
import 'edit.dart';
class MyList extends StatefulWidget {
  MyList({Key? key}): super(key:key);


  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  var users = <User>[];
  Future<List<User>> getAll() async {
    var data = await http.get(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU"),
        headers: {"Content-Type": "application/json","Accept": "application/json"});
    var jsonData = json.decode(data.body);
    List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
    Iterable list = json.decode(data.body);

    // print("jsonDatajsonDatajsonData ${users[0].firstName}");
    // List<User> users =[];
    /*  for(var u in jsonData){

         *//* User user =User(u['id'],u['name'],u['email'],u['password']);
          users.add(user);*//*
    }*/
    if(data.statusCode==201 ||data.statusCode==200){
      users = list.map((model) => User.fromJson(model)).toList();
    }else {
      print('error !');
    }
    //  print(users.length);
    return users;
  }
  List<User>? _value;
  @override
  void initState() async{
    _value = await getAll() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAll(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return const CircularProgressIndicator();
          }else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                  return  ListTile(
                    title: Text(snapshot.data[index].firstName),
                    subtitle: Text(snapshot.data[index].firstName),
                  );
                }
            );}

        }
    );
  }
  editUser(item){
    var userId = item['id'].toString();
    var fisrtName = item['firstNAme'].toString();
    var lastName = item['lastNAme'].toString();
    var email = item['email'].toString();
    var telephone = item['telephone'].toString();

    Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(userId: userId, firstName: fisrtName, lastName: lastName, email: email, telephone: telephone,)));
  }
  deleteUser(userId) async {
    var response = await http.post(Uri.parse("${ServerConfig.serverAdressess}::8090/api/v1/users/del/$userId"),headers: {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    });
    if(response.statusCode == 200){
      User;
    }
  }
  showDeleteAlert(BuildContext context,item) {

    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No",style: TextStyle(color: primary),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes",style: TextStyle(color: primary)),
      onPressed:  () {
        Navigator.pop(context);

        deleteUser(item['id']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this user?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

