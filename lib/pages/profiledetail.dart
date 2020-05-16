import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Profile',
        style: GoogleFonts.nunitoSans(
          letterSpacing: 1,
          color: Colors.white,
        ),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: height*0.25,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/costella.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/login_bg.png'),
                        radius: height*0.1,
                      ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.5),
                        blurRadius: 20,
                        offset: Offset(0, 10))
                  ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        'Shop Name:',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      AutoSizeText(
                        'Udupi Stores',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                      ),
                      Divider(height: height*0.04,),
                      AutoSizeText(
                        'Address:',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      AutoSizeText(
                        'Near Service Bus stand Udupi,'
                            'Udupi 576100',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                      ),
                      Divider(height: height*0.04,),
                      AutoSizeText(
                        'Contact:',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      AutoSizeText(
                        '9740568512 ',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                      ),
                      Divider(height: height*0.04,),
                      AutoSizeText(
                        'Total Orders:',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      AutoSizeText(
                        '20',
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20,0,20,10),
              child: GestureDetector(
                onTap: (){print('logout');},
                child: Container(
                  height: height*0.1,
                  width: width*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey[800],
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, 0.5),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]
                  ),
                  child: Center(
                    child: AutoSizeText(
                      'LOGOUT',
                      style: GoogleFonts.nunitoSans(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

