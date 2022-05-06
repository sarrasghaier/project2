import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forum_republique/pages/user_screen.dart';
import 'package:forum_republique/theme/theme_helper.dart';
import '../api/server_config.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import '../pages/widgets/header_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http ;



class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  Future save() async {
/*    final msg = jsonEncode(<String, String>{
      "email": "eeeeeeeeee",
      "firstName": "string",
      "lastName": "string",
      "password": "string",
      "resetPasswordToken": "string",
      "telephone": "string"
    });
    Map<String, String> headers = {
      "Context-Type": "application/json",
      "Accept": "application/json",
    };*/
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
        "password": passwordController.text,

      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }

  String  url = "";

  _login() async {
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    // Image(
                    //    image: NetworkImage('data:image/png;base64,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'),
                    //   height: 100,
                    //   width: 100,
                    // ),
                    Text(
                        'FORUM DE LA REPUBLIQUE',
                      style: TextStyle(
                          color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Text(
                      'connectez-vous à votre compte',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration('Nom d\'utilisateur', 'Entrez votre nom d\'utilisateur'
                                ),
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return  "Entrer votre nom !";
                                  }

                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextFormField(
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Mot de passe', 'Entrez votre Mot de passe'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Entrer votre mot de passe";
                                    } else if (val.length<8) {
                                      return "Entrer un mot de passe valide";
                                    }
                                  }
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( "Mot de passe oublié?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('identifier'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => ProfilePage()
                                        ),
                                            (Route<dynamic> route) => false
                                    );
                                  }
                                  //After successful login we will redirect to profile page. Let's create profile page now

                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "vous n'avez pas de compte? "),
                                    TextSpan(
                                      text: 'Créer',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}
