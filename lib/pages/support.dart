import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {

  Map supportData;
  List supportList;

  int stackIndex = 0;

  Future getSupport() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getSupport.php');
    if (response.body.toString() == 'no') {
      supportList = null;
    } else {
      supportData = json.decode(response.body);
      setState(() {
        supportList = supportData['support'];
        stackIndex = 1;
      });
      print(supportList.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSupport();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Support',
        style: GoogleFonts.nunitoSans(
          letterSpacing: 1,
          color: Colors.white,
        ),),
        elevation: 0,
        backgroundColor: Colors.grey[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(4),
        child: IndexedStack(
          index: stackIndex,
          children: <Widget>[
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: AssetImage('assets/images/loading.png'),
                      fit: BoxFit.contain)),
            ),
            ListView.builder(
              itemBuilder: (context,index)
              {
                return support(index);
              },
              itemCount: supportList == null ? 0 : supportList.length,
            ),
          ],
        )
      ),
    );
  }

  support(int index)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child:Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Icon(Icons.person,size: width*0.2,color: Colors.grey[800],)
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              supportList[index]['name'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            AutoSizeText(
                              supportList[index]['designation'],
                              style: GoogleFonts.nunitoSans(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    String url = supportList[index]['mail'];
                                    loadURL('mailto:$url?subject=Suppot Message&body=Hey Team!'
                                        'Need help.');
                                  },
                                  icon: Icon(Icons.mail),
                                  iconSize: width*0.08,
                                  color: Colors.grey[800],
                                ),
                                SizedBox(width: width*0.02,),
                                IconButton(
                                  onPressed: () {
                                    String phone = supportList[index]['phone'];
                                    loadURL('sms:$phone');
                                  },
                                  icon: Icon(Icons.message),
                                  iconSize:  width*0.08,
                                  color: Colors.grey[800],
                                ),
                                SizedBox(width: width*0.02,),
                                IconButton(
                                  onPressed: () {
                                    String phone = supportList[index]['phone'];
                                    loadURL('tel:$phone');
                                  },
                                  icon: Icon(Icons.call),
                                  iconSize:  width*0.08,
                                  color: Colors.grey[800],
                                ),
                              ],
                            ),
                          ],

                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

  loadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
