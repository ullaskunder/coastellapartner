import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController shopID = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  final RoundedLoadingButtonController loginButton = new RoundedLoadingButtonController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.5),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    padding: EdgeInsets.all(10),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: shopID,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Shop ID',
                              hintStyle: TextStyle(
                                color: Colors.red[200],
                              ),
                            ),
                          ),
                          Divider(),
                          TextField(
                            controller: phoneNumber,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: Colors.red[200],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                RoundedLoadingButton(
                  color: Colors.red,
                  child: AutoSizeText(
                      'Login',
                      style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 20
                      ),
                  ),
                  controller: loginButton,
                  onPressed: _doSomething,
                )
               /* Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.5),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    width:  MediaQuery.of(context).size.width * 0.4,
                    height:  MediaQuery.of(context).size.height * 0.07,
                    child:Container(
                      child: FlatButton(
                        onPressed: () {
                          getData();
                        },
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ));
  }

  void getData()
  {
    if(shopID.text.isEmpty)
    {
      errorMessage('Enter a shop ID');
      print('Enter shop id');
    }
    if(phoneNumber.text.isEmpty)
    {
      errorMessage('Enter a phone number');
      print('Enter phone number');
    }
    if(shopID.text.isNotEmpty && phoneNumber.text.isNotEmpty)
    {
      errorMessage('Loading....');
      print(shopID.text + phoneNumber.text);
      saveLoginState();
    }
  }

  void saveLoginState() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('login', 'done');
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));

  }

  void errorMessage(String status)
  {
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.message),
                title: Text('$status'),
                onTap: () => {Navigator.pop(context)},
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Close'),
                onTap: () => {Navigator.pop(context)},
              )
            ],
          );
        }
    );
  }
  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      print('hello');
      loginButton.success();
    });
  }
}
