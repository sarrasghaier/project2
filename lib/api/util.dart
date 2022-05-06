import 'package:flutter/material.dart';

import '../adherants_screen/listeUser.dart';
import '../theme/theme_colors.dart';


showMessage(BuildContext context,String contentMessage) {


    Widget yesButton = FlatButton(
      child: Text("OK",style: TextStyle(color: primary)),
      onPressed:  () {
        Navigator.pop(context);
        
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        listePage()), (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(contentMessage),
      actions: [
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