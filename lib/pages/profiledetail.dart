import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/login.dart';
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
                leading: Icon(Icons.remove_circle_outline,color: Colors.red[900],),
                title: AutoSizeText(
                  '$status',
                  style: GoogleFonts.nunitoSans(
                    letterSpacing: 1,
                    color: Colors.red[900],
                  ),
                ),
                onTap: () => {
                  Navigator.pop(context),
                  logout(),
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel,color: Colors.blueGrey[900],),
                title: AutoSizeText(
                  'CLOSE',
                  style: GoogleFonts.nunitoSans(
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
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

  void errorMessage(String status) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.message),
                title: Text('$status'),
                //onTap: () => {Navigator.pop(context)},
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Close'),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()))
                },
              )
            ],
          );
        });
  }

  Future updateShopProfile() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/editShopProfile.php',
        body: {'shopid': shopId,'name':name.text,'address':address.text,'phone':phone.text});
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('Profile Updated Successfully');
        errorMessage('Profile Updated Successfully');
      } else {
        print('Failed To Update Profile');
        errorMessage('Failed To Update Profile');
      }
    } else {
      print('Failed To Update Profile');
      errorMessage('Failed To Update Profile');
    }
  }

  void getTextFieldData() {
    if (name.text.isEmpty && address.text.isEmpty && phone.text.isEmpty) {
      errorMessage('Enter the details');
    }
    else if (name.text.isEmpty) {
      errorMessage('Enter the name');
    }else if (address.text.isEmpty) {
      errorMessage('Enter the address');
    }else if (phone.text.isEmpty) {
      errorMessage('Enter the phone number');
    }
    else {
      updateShopProfile();
    }
  }

  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  Widget editShopProfile()
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
            width: width,
            height: height*0.6,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child:  AutoSizeText(
                          '   EDIT PROFILE',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontSize: 20,
                            color: Colors.blueGrey[900],
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: ()
                          {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height*0.02,
                  ),
                  TextField(
                    controller: name,
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Shop Name',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.05,
                  ),
                  TextField(
                    controller: address,
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Address',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.05,
                  ),
                  TextField(
                    controller: phone,
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.05,
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.of(context).pop();
                      getTextFieldData();

                    },
                    child: Container(
                      width: width,
                      height: height*0.08,
                      decoration: BoxDecoration(
                        color: Colors.green[900],
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'SUBMIT',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

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
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          'Profile Details',
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: ()
            {
              showDialog(
                  context: context,
                  builder: (BuildContext context)
                  {
                    return editShopProfile();
                  }
              );
              },
          ),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            color: Colors.white,
            onPressed: ()
            {
              logoutBottomSheet('LOGOUT');
            },
          ),
        ],
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
                        fit: BoxFit.fitWidth,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          ),
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
                                    color: Colors.grey
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
                              Divider(
                                height: height * 0.04,
                              ),
                              AutoSizeText(
                                'Shop Name:',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 14,
                                    color: Colors.grey
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
                                    color: Colors.grey
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
                                    color: Colors.grey
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
                                    color: Colors.grey
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              AutoSizeText(
                                shopDetailsList[index]['rating'] == null
                                    ? '0★'
                                    : shopDetailsList[index]['rating']+'★',
                                style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.amber[900],
                                ),
                              ),
                            ],
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
