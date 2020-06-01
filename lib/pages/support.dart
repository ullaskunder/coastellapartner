import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
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
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Support',
        style: GoogleFonts.nunitoSans(
          letterSpacing: 1,
          color: Colors.white,
        ),),
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
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
                  color: Colors.blueGrey[900],
                  image: DecorationImage(
                      image: AssetImage('assets/images/loading.png'),
                      fit: BoxFit.contain)),
            ),
           Column(
             children: <Widget>[
               Container(
                 height: height*0.3,
                 width: width,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage('assets/images/support.png'),
                     fit: BoxFit.contain,
                   ),
                 ),
               ),
               SizedBox(height: height * 0.02,),
               Expanded(
                 child: ListView.builder(
                   itemBuilder: (context,index)
                   {
                     return support(index);
                   },
                   itemCount: supportList == null ? 0 : supportList.length,
                 ),
               ),
             ],
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
          color: Colors.white,
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child:Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                   Expanded(
                          flex: 2,
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(supportList[index]['image']),
                              radius: 50,
                              backgroundColor: Colors.blueGrey[900],
                            ),

                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AutoSizeText(
                              ' ' + supportList[index]['name'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            AutoSizeText(
                              ' ' + supportList[index]['designation'],
                              style: GoogleFonts.nunitoSans(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: height*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    String url = supportList[index]['mail'];
                                    loadURL('mailto:$url?subject=Suppot Message&body=Hey Team!'
                                        'Need help.');
                                  },
                                  icon: Icon(Icons.mail,color: Colors.red[800],),
                                  iconSize: width*0.08,
                                  color: Colors.grey[800],
                                ),
                                IconButton(
                                  onPressed: () {
                                    String phone = supportList[index]['phone'];
                                    loadURL('sms:$phone');
                                  },
                                  icon: Icon(Icons.message,color: Colors.blue[800],),
                                  iconSize:  width*0.08,
                                  color: Colors.grey[800],
                                ),
                                IconButton(
                                  onPressed: () {
                                    String name = supportList[index]['name'];
                                    String mail = supportList[index]['mail'];
                                    String phone = supportList[index]['phone'];
                                    Share.share(name+'\n'+mail+'\n'+phone);
                                  },
                                  icon: Icon(Icons.share,color: Colors.amber[800],),
                                  iconSize:  width*0.08,
                                  color: Colors.grey[800],
                                ),
                                IconButton(
                                  onPressed: () {
                                    String phone = supportList[index]['phone'];
                                    loadURL('tel:$phone');
                                  },
                                  icon: Icon(Icons.call,color: Colors.green[800],),
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
