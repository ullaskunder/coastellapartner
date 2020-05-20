import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  Map teamData;
  List teamList;

  int stackIndex = 0;

  Future getTeamMembers() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getTeamMembers.php');
    if (response.body.toString() == 'no') {
      teamList = null;
    } else {
      teamData = json.decode(response.body);
      setState(() {
        teamList = teamData['team'];
        stackIndex = 1;
      });
      print(teamList.toString());
    }
  }

  loadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getTeamMembers();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: height*0.26,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Team Coastella',
                style: GoogleFonts.nunitoSans(
                  letterSpacing: 1,
                  color: Colors.white,
                ),),
                centerTitle: true,
                background: Padding(
                  padding: EdgeInsets.fromLTRB(0,0,20,60),
                  child: Image.asset('assets/images/icon_light.png',
                  fit: BoxFit.contain,),
                ),
              ),
            ),
            SliverFillRemaining(
              child: ListView.builder(
                  itemBuilder: (context,index)
                      {
                        return teamMembersList(index);
                      },
                itemCount: teamList == null ? 0 : teamList.length,
              ),
              /*SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Container(
                  width: width,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.adb,
                          size: height * 0.06,
                          color: Colors.grey[800],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          'APP DEVELOPERS :',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/

                    teamMembersList('Ullas Kunder', 'App Developer'),
                    /*Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Container(
                  width: width,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.web,
                          size: height * 0.06,
                          color: Colors.grey[800],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          'WEB DEVELOPERS :',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
                    teamMembersList('Saurabh Shetty', 'Web Developer'),
                    teamMembersList('Chethan Poojary', 'Web Developer'),
                    /*Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Container(
                  width: width,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.send,
                          size: height * 0.06,
                          color: Colors.grey[800],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: AutoSizeText(
                          'Marketing :',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
                    teamMembersList('Princeton Lewis', 'Digital Marketing'),
                    teamMembersList('Sooraj Shetty', 'Digital Marketing'),
                    teamMembersList('Shamith Joshi', 'Digital Marketing'),
                    teamMembersList('Anirudh Rao', 'Marketing'),
                    teamMembersList('Abhijith Serigara', 'Marketing'),
                    teamMembersList('Hithyesh', 'Marketing'),
                  ],
                ),
              ),*/
            ),
          ],
        ),
      ),
    );
  }

  teamMembersList(int index)
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
                              teamList[index]['name'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            AutoSizeText(
                              teamList[index]['designation'],
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
                                    String url = teamList[index]['mail'];
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
                                    String phone = teamList[index]['phone'];
                                    loadURL('sms:$phone');
                                  },
                                  icon: Icon(Icons.message),
                                  iconSize:  width*0.08,
                                  color: Colors.grey[800],
                                ),
                                SizedBox(width: width*0.02,),
                                IconButton(
                                  onPressed: () {
                                    String phone = teamList[index]['phone'];
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

  /*teamMembersList() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(10,10,10,5),
      child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.perm_identity,
                        size: width * 0.1,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                'Name',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 24,
                                ),
                              ),
                              AutoSizeText(
                                'Des',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mail),
                      iconSize: width * 0.06,
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call),
                      iconSize: width * 0.06,
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.message),
                      iconSize: width * 0.06,
                      color: Colors.grey[800],
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      iconSize: width * 0.06,
                      color: Colors.grey[800],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      iconSize: width * 0.06,
                      color: Colors.grey[800],
                    ),

                  ],
                ),
              ],
            ),
          )),
    );
  }*/
}
