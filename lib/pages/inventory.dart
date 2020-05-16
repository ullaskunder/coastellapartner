import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/feedback.dart';
import 'package:costellapartner/pages/teamcoastella.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:costellapartner/pages/support.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SupportPage()));
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60)),
                            color: Color.fromRGBO(255, 255, 255, 0.6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Icon(
                              Icons.call,
                              color: Colors.grey[800],
                              size: height * 0.1,
                            )),
                            AutoSizeText(
                              'SUPPOT',
                              style: GoogleFonts.nunitoSans(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => FeedBackPage()));
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(60)),
                            color: Color.fromRGBO(255, 255, 255, 0.6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Icon(
                              Icons.feedback,
                              color: Colors.grey[800],
                              size: height * 0.1,
                            )),
                            AutoSizeText(
                              'FEEDBACK',
                              style: GoogleFonts.nunitoSans(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        loadURL('mailto:service@coastella.in?subject=Contact Mail&body=Hey Developers.');
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(60)),
                            color: Color.fromRGBO(255, 255, 255, 0.6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Icon(
                              Icons.contact_mail,
                              color: Colors.grey[800],
                              size: height * 0.1,
                            )),
                            AutoSizeText(
                              'CONTACT',
                              style: GoogleFonts.nunitoSans(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TeamPage()));
                      },
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.42,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topRight: Radius.circular(60)),
                            color: Color.fromRGBO(255, 255, 255, 0.6)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Icon(
                              Icons.developer_board,
                              color: Colors.grey[800],
                              size: height * 0.1,
                            )),
                            AutoSizeText(
                              'TEAM',
                              style: GoogleFonts.nunitoSans(
                                color: Colors.grey[800],
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Share.share('check out my website http://coastella.in', subject: 'Look what I made!');
                },
                child: Container(
                  width: width * 0.9,
                  height: height * 0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      color: Color.fromRGBO(255, 255, 255, 0.6)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: AutoSizeText(
                            'Share',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: Colors.grey[800],
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.share,
                            color: Colors.grey[800],
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  loadURL('http://coastella.in/');
                },
                child: Container(
                  width: width * 0.9,
                  height: height * 0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      color: Color.fromRGBO(255, 255, 255, 0.6)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: AutoSizeText(
                            'Website',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: Colors.grey[800],
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.web,
                            color: Colors.grey[800],
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
