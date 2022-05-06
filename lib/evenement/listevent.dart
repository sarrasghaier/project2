import 'package:flutter/material.dart';
import 'package:forum_republique/adherants_screen/user.dart';
import 'package:forum_republique/api/server_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'eve.dart';
class EventList extends StatefulWidget {
  EventList({Key? key}): super(key:key);


  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  var events = <eve>[];
  Future<List<eve>> getAll() async {
    var data = await http.get(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/event/GetAll"),
        headers: {"Content-Type": "application/json","Accept": "application/json"});
    var jsonData = json.decode(data.body);
    List<eve> userFromJson(String str) => List<eve>.from(json.decode(str).map((x) => eve.fromJson(x)));
    Iterable list = json.decode(data.body);

    // print("jsonDatajsonDatajsonData ${users[0].firstName}");
    // List<User> users =[];
    /*  for(var u in jsonData){

         *//* User user =User(u['id'],u['name'],u['email'],u['password']);
          users.add(user);*//*
    }*/
    if(data.statusCode==201 ||data.statusCode==200){
      events = list.map((model) => eve.fromJson(model)).toList();
    }else {
      print('error !');
    }
    //  print(users.length);
    return events;
  }
  List<eve>? _value;
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
}

