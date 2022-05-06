import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../auth/registration_page.dart';
import '../theme/theme_colors.dart';
import '../api/server_config.dart';
import 'edit.dart';


class listePage extends StatefulWidget {
  @override

  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<listePage> {
  List users = [];
  bool isLoading = false;
  @override

  void initState(){
    // TODO: implement initState
    super.initState();
    fetchUser();

  }

   fetchUser() async {
    setState(() {
      isLoading = true;
    }
    );
    var response = await http.get(Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users"));
    if(response.statusCode == 200){
      var items = json.decode(response.body)['data'];
      setState(() {
        users = items;
        isLoading = false;
      });
    }

    else{
      setState(() {
        users = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listing Users"),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
          }, child: Icon(Icons.add,color: white,))
        ],
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    if(isLoading || users.length == 0){
      return Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primary)
      ));
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
      return cardItem(users[index]);
    });
  }
  Widget cardItem(item){
    return Card(
          child: Slidable(
            key: const ValueKey(0),
              endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                 SlidableAction(
                  onPressed: editUser(item) ,
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.update,
                  label: 'Edit',
              ),
                  SlidableAction(
                  onPressed: showDeleteAlert(context,item),
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  ),
              ],
              ), child: const ListTile(title: Text('Slide me')),
          )
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
      this.fetchUser();
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