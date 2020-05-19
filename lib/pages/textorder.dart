import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/orderlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class TextOrder extends StatefulWidget {
  final int index;
  final List data;

  TextOrder(this.index, this.data, {Key key}) : super(key: key);

  @override
  _TextOrderState createState() => _TextOrderState();
}

class _TextOrderState extends State<TextOrder> {

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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()))
                },
              )
            ],
          );
        });
  }

  loadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void acceptOrder() async {
    errorMessage('Uploading');
    var url = 'http://coastella.in/coastellapartner/php/acceptOrder.php';
    Map data = {"oid":widget.data[widget.index]['oid']};

    var response = await http.post(url, body: data);
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('Order Accepted');
        errorMessage('Order Accepted');
      } else {
        print('Failed to accept order! Try again');
        errorMessage('Failed to accept order! Try again');
      }
    } else {
      print('Failed to accept order! Try again');
      errorMessage('Failed to accept order! Try again');
    }
  }

  void packOrder() async {
    var url = 'http://coastella.in/coastellapartner/php/packOrder.php';
    Map data = {"oid":widget.data[widget.index]['oid']};

    var response = await http.post(url, body: data);
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('Order Packed');
        errorMessage('Order Packed');
      } else {
        print('Failed to pack order! Try again');
        errorMessage('Failed to pack order! Try again');
      }
    } else {
      print('Failed to pack order! Try again');
      errorMessage('Failed to pack order! Try again');
    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          widget.data[widget.index]['oid'],
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AutoSizeText(
                    'Items List : \n' + widget.data[widget.index]['orderList'],
                    style: GoogleFonts.nunitoSans(
                        letterSpacing: 1,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AutoSizeText(
                        'Buyer Name : ' + widget.data[widget.index]['name'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                      Divider(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        'Address : ' + widget.data[widget.index]['address'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                      Divider(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        'Phone Number : ' + widget.data[widget.index]['phone'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                      Divider(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        'Carry Bag : ' +
                            (widget.data[widget.index]['isCarryBag'] == 1
                                ? 'Yes'
                                : 'No'),
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                      Divider(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        'Carton Box : ' +
                            (widget.data[widget.index]['isCartonBox'] == 1
                                ? 'Yes'
                                : 'No'),
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                      Divider(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        'Pickup Time : ' +
                            widget.data[widget.index]['userPickupTime'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                      Divider(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        'User Comment : ' + widget.data[widget.index]['userComment'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      final number = widget.data[widget.index]['phone'];
                      loadURL('tel:$number');
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'CALL',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      acceptOrder();
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'ACCEPT',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      packOrder();
                    },
                    child: Container(
                      height: height * 0.08,
                      width: width * 0.28,
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'PACKED',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 16),
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
    );
  }
}
