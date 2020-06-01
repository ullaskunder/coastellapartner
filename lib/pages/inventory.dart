import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/feedback.dart';
import 'package:costellapartner/pages/teamcoastella.dart';
import 'package:costellapartner/pages/termsandconditions.dart';
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
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          'Utilities',
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
        actions: <Widget>[
          IconButton(
            onPressed: ()
            {
              Share.share('Hey, Check this app',subject: 'coastella.in');
            },
            icon: Icon(Icons.share,color: Colors.white,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SupportPage()));
                    },
                    child: Container(
                      width: width * 0.45,
                      height: height*0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/support.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'SUPPORT',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  color: Colors.blueGrey[900],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      loadURL('mailto:coastella@gmail.com?subject=Coastella-Partner&body=Hey Team Coastella');
                    },
                    child: Container(
                      width: width * 0.45,
                      height: height*0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/email.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'E-MAIL',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  color: Colors.blueGrey[900],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => FeedBackPage()));
                    },
                    child: Container(
                      width: width * 0.45,
                      height: height*0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/feedback.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'FEEDBACK',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  color: Colors.blueGrey[900],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext contex) => TCPage()
                        )
                      );
                    },
                    child: Container(
                      width: width * 0.45,
                      height: height*0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/tandc.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'T & C',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  color: Colors.blueGrey[900],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()
                    {
                      loadURL('http:coastella.in');
                    },
                    child: Container(
                      width: width * 0.45,
                      height: height*0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/website.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'WEBSITE',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  color: Colors.blueGrey[900],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TeamPage()));
                    },
                    child: Container(
                      width: width * 0.45,
                      height: height*0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/team.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              'TEAM',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  color: Colors.blueGrey[900],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
