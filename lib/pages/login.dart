import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    shopID.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  TextEditingController shopID = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  final RoundedLoadingButtonController loginButton =
      new RoundedLoadingButtonController();



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: height,
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.1,
                  ),
                      Container(
                        height: height * 0.4,
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/login_bg.jpg'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),

                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                blurRadius: 40,
                                offset: Offset(5, 5))
                          ]),
                      padding: EdgeInsets.all(10),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: shopID,
                              style: GoogleFonts.nunitoSans(
                                letterSpacing: 2,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Shop ID',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                            Divider(
                              height: height * 0.04,
                            ),
                            TextField(
                              controller: phoneNumber,
                              style: GoogleFonts.nunitoSans(letterSpacing: 2),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  RoundedLoadingButton(
                    width: width * 0.8,
                    color: Colors.blue[800],
                    child: AutoSizeText(
                      'Login',
                      style: GoogleFonts.nunitoSans(
                          color: Colors.white, letterSpacing: 2, fontSize: 20),
                    ),
                    controller: loginButton,
                    onPressed: () {
                      loadAnimation();
                      getTextFieldData();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void getTextFieldData() {
    if (shopID.text.isEmpty && phoneNumber.text.isEmpty) {
      errorMessage('Enter shop ID and Phone number');
      print('Enter shop id');
    } else if (shopID.text.isEmpty) {
      errorMessage('Enter a shop id');
      print('Enter phone number');
    } else if (phoneNumber.text.isEmpty) {
      errorMessage('Enter a phone number');
      print('Enter phone number');
    } else {
      checkLogin();
      print(shopID.text + phoneNumber.text);
    }
  }

  Future saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
      prefs.setString('login', 'done');
      prefs.setString('shopId', shopID.text);
      prefs.setString('phoneNumber', phoneNumber.text);
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  void errorMessage(String status) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.message),
                title: Text('$status'),
                //onTap: () => {Navigator.pop(context)},
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Close'),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()))
                },
              )
            ],
          );
        });
  }

  void loadAnimation() async {
    Timer(Duration(seconds: 3), () {
      loginButton.success();
    });
  }

  void checkLogin() async {
    String id = shopID.text;
    String num = phoneNumber.text;

    var url = 'http://coastella.in/coastellapartner/php/login.php';
    Map data = {"shopid": id, "phonenumber": num};

    var response = await http.post(url, body: data);
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('login done');
        saveLoginState();
      } else {
        print('login failed');
        errorMessage('Login Failed! Try again');
      }
    } else {
      print('login failed');
      errorMessage('Login Failed! Try again');
    }
  }
}
