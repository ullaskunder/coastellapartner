import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.red,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: height,
            width: width,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.08,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/costella.png'),
                  radius: width * 0.18,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                AutoSizeText(
                  'Shop Name',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 40, color: Colors.white, letterSpacing: 2),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    print('hello');
                  },
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Color.fromRGBO(255, 255, 255, 0.5)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.06, 0, 0, 0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.04, 0, 0, 0),
                          child: AutoSizeText(
                            'Profile',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.44, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    print('hello');
                  },
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Color.fromRGBO(255, 255, 255, 0.5)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.06, 0, 0, 0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.04, 0, 0, 0),
                          child: AutoSizeText(
                            'Feedback',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.37, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    width: width,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Color.fromRGBO(255, 255, 255, 0.5)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.06, 0, 0, 0),
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.04, 0, 0, 0),
                          child: AutoSizeText(
                            'Logout',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.44, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> logout() async {
    //showSnackBarMessage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('login', '');
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    });
  }

  /*void showSnackBarMessage() {
    final snackBar = new SnackBar(
      content: Text('Logging out'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }*/
}
