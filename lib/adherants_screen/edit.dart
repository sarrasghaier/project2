import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/base_api.dart';
import '../api/util.dart';
import '../theme/theme_colors.dart';
import '../api/server_config.dart';
class EditUser extends StatefulWidget {
  String userId;
  String firstName;
  String lastName;
  String telephone;
  String email;
  EditUser({required this.userId,required this.firstName,required this.lastName,required this.telephone,required this.email});
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      userId = widget.userId;
      email: emailController.text;
      firstName: firstNameController.text;
      lastName: lastNameController.text;
      password: passwordController.text;
      telephone: phoneNumberController.text;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edition User"),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(height: 30,),
        TextField(
          controller: firstNameController,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "FirstName",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: lastNameController,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "LastName",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: phoneNumberController,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "PhoneNumber",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: emailController,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Email",
          ),
        ),
        SizedBox(height: 40,),
        FlatButton(
        color: primary,
        onPressed: (){
          editUser();
        }, child: Text("Done",style: TextStyle(color: white),))
      ],
    );
  }
  editUser() async {

    var firstName = firstNameController.text;
    var lastName = lastNameController.text;
    var telephone = phoneNumberController.text;
    var email = emailController.text;
    if(firstName.isNotEmpty && email.isNotEmpty){
      var url = BASE_API+"/users/$userId";
      var bodyData = json.encode({
        "firstname" : firstName,
        "lastname" : lastName,
        "telephone" : telephone,
        "email" : email
      });
      var response = await http.post(Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/$userId"),headers: {
        "Content-Type" : "application/json",
        "Accept" : "application/json"
      },body: bodyData);
      if(response.statusCode == 200){
        var messageSuccess = json.decode(response.body)['message'];
        showMessage(context,messageSuccess);
      }else {
         var messageError = "Can not update this user!!";
        showMessage(context,messageError);
      }
    }
  }
}