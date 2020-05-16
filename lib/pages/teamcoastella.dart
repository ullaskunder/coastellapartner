import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Team Coastella',
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
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
            ),
            teamMembersList('Deepak Nayak', 'App Developer'),
            teamMembersList('Ullas Kunder', 'App Developer'),
            Padding(
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
            ),
            teamMembersList('Saurabh Shetty', 'Web Developer'),
            teamMembersList('Chethan Poojary', 'Web Developer'),
            Padding(
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
            ),
            teamMembersList('Princeton Lewis', 'Digital Marketing'),
            teamMembersList('Sooraj Shetty', 'Digital Marketing'),
            teamMembersList('Shamith Joshi', 'Digital Marketing'),
            teamMembersList('Anirudh Rao', 'Marketing'),
            teamMembersList('Abhijith Serigara', 'Marketing'),
            teamMembersList('Hithyesh', 'Marketing'),
          ],
        ),
      ),
    );
  }

  teamMembersList(String name, String designation) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                                '$name',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 24,
                                ),
                              ),
                              AutoSizeText(
                                '$designation',
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
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
