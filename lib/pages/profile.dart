import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/login.dart';
import 'package:costellapartner/pages/profiledetail.dart';
import 'package:costellapartner/pages/orderhistory.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> logout() async {
    //showSnackBarMessage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('shopId');
      prefs.remove('login');
      prefs.remove('phoneNumber');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    });
  }

  void logoutBottomSheet(String status) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.remove_circle_outline),
                title: Text(
                  '$status',
                  style: GoogleFonts.nunitoSans(
                    letterSpacing: 1,
                  ),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  logout(),
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text(
                  'Close',
                  style: GoogleFonts.nunitoSans(
                    letterSpacing: 1,
                  ),
                ),
                onTap: () => {
                  Navigator.pop(context),
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: height,
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.06,
                  ),
              Container(
                height: height*0.26,
                width: width*0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/icon_circular.png'),
                    fit: BoxFit.contain
                  ),
                ),
              ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  AutoSizeText(
                    'Coastella - Partner',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 32,
                        color: Colors.grey[800],
                        letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('hello');
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfileDetail()));
                    },
                    child: Container(
                      width: width,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Color.fromRGBO(255, 255, 255, 0.6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey[800],
                              size: 28,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: AutoSizeText(
                              'Profile',
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
                              Icons.arrow_forward_ios,
                              color: Colors.grey[800],
                              size: 28,
                            ),
                          ),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => OrderHistory()));
                    },
                    child: Container(
                      width: width,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Color.fromRGBO(255, 255, 255, 0.6)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.history,
                              color: Colors.grey[800],
                              size: 28,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: AutoSizeText(
                              'Orders History',
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
                              Icons.arrow_forward_ios,
                              color: Colors.grey[800],
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      logoutBottomSheet('LOGOUT');
                      //showAlertDialog();
                    },
                    child: Container(
                      width: width,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Color.fromRGBO(255, 255, 255, 0.6)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.grey[800],
                              size: 28,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: AutoSizeText(
                              'Logout',
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
                              Icons.arrow_forward_ios,
                              color: Colors.grey[800],
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }



/*showAlertDialog()
  {
    return  Alert(
      context: context,
      type: AlertType.none,
      title: "CONFIRMATION",
      desc: "DO you wanr to logout?",
      buttons: [
        DialogButton(
          child: Text(
            "LOGOUT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            logout();
            Navigator.pop(context);

            },
          color: Colors.green[800],
        ),
        DialogButton(
          child: Text(
            "CANCELL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red[800],
        ),

      ],
    ).show();
  }*/

/*void showSnackBarMessage() {
    final snackBar = new SnackBar(
      content: Text('Logging out'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }*/
}
