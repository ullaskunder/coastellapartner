import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffc62828),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){print('Support');},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: height * 0.26,
                        width: width * 0.45,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Icon(
                                  Icons.add_call,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  'Support',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.032,
                    ),
                    GestureDetector(
                      onTap: (){print('Developers');},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: height * 0.26,
                        width: width * 0.45,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Icon(
                                  Icons.developer_mode,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  'Developers',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){print('Contact');},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: height * 0.26,
                        width: width * 0.45,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Icon(
                                  Icons.contact_mail,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  'Contact',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.032,
                    ),
                    GestureDetector(
                      onTap: (){print('Feedback');},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: height * 0.26,
                        width: width * 0.45,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Icon(
                                  Icons.edit,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  'FeedBack',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){print('Website');},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: height * 0.24,
                        width: width * 0.92,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Icon(
                                  Icons.web,
                                  size: 60,
                                  color: Colors.white,
                                ),
                                AutoSizeText(
                                  'Website',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
