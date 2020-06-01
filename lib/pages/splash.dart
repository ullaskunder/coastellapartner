import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String val;

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      val = (prefs.getString('login') ?? '');
    });
    print('login : ' + val);
    await Future.delayed(Duration(seconds: 4));
    if (val == 'done')
      return true;
    else
      return false;
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    checkForInternetConnectivity();
  }

  void checkForInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isLoggedIn().then((value) {
          if (value) {
            navigateToHome();
          } else {
            navigateToLogin();
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      errorMessage('Please check your internet connection!');
    }
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
                leading:
                    Icon(Icons.signal_cellular_connected_no_internet_4_bar),
                title: Text('$status'),
                //onTap: () => {Navigator.pop(context)},
              ),
              ListTile(
                leading: Icon(Icons.swap_vertical_circle),
                title: Text('Try Again'),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => SplashPage()))
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Shimmer.fromColors(
            child: Container(
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    'COASTELLA',
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 1,
                      fontSize: 40,
                    ),
                  ),
                  AutoSizeText(
                    'PARTNER',
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 1,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            baseColor: Colors.grey[800],
            highlightColor: Colors.white),
      ),
    );
  }
}
