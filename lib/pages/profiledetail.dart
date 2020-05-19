import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  String shopId, phoneNumber;
  int stackIndex = 0;

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopId = (prefs.getString('shopId') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
      getShopDetails();
    });
  }

  Map shopDetailsData;
  List shopDetailsList;

  Future getShopDetails() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getShopDetails.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      shopDetailsList = null;
    } else {
      shopDetailsData = json.decode(response.body);
      setState(() {
        shopDetailsList = shopDetailsData['shops'];
        stackIndex = 1;
      });
      print(shopDetailsList.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getSP();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Profile',
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: IndexedStack(
        index: stackIndex,
        children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/loading.png'),
              fit: BoxFit.contain,
            )),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: height * 0.25,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: CachedNetworkImageProvider(
                                    shopDetailsList[index]['sImage']) ==
                                null
                            ? AssetImage('assets/images/loading.png')
                            : CachedNetworkImageProvider(
                                shopDetailsList[index]['sImage']),
                        fit: BoxFit.contain,
                      )),
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
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                'Shop ID:',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              AutoSizeText(
                                shopDetailsList[index]['sid'] == null
                                    ? 'Shop ID'
                                    : shopDetailsList[index]['sid'],
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                ),
                              ),
                              AutoSizeText(
                                'Shop Name:',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              AutoSizeText(
                                shopDetailsList[index]['name'] == null
                                    ? 'Shop Name'
                                    : shopDetailsList[index]['name'],
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                ),
                              ),
                              Divider(
                                height: height * 0.04,
                              ),
                              AutoSizeText(
                                'Address:',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              AutoSizeText(
                                shopDetailsList[index]['address'] == null
                                    ? 'Address'
                                    : shopDetailsList[index]['address'],
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                ),
                              ),
                              Divider(
                                height: height * 0.04,
                              ),
                              AutoSizeText(
                                'Contact:',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              AutoSizeText(
                                shopDetailsList[index]['phone'] == null
                                    ? 'Phone Number'
                                    : shopDetailsList[index]['phone'],
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                ),
                              ),
                              Divider(
                                height: height * 0.04,
                              ),
                              AutoSizeText(
                                'Rating:',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              AutoSizeText(
                                shopDetailsList[index]['rating'] == null
                                    ? '0'
                                    : shopDetailsList[index]['rating'],
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
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: GestureDetector(
                        onTap: () {
                          print('logout');
                        },
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.grey[800],
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Center(
                            child: AutoSizeText(
                              'LOGOUT',
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: shopDetailsList == null ? 0 : shopDetailsList.length,
          )
        ],
      ),
    );
  }
}
