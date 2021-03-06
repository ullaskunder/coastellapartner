import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class OrderHistoryDetails extends StatefulWidget {
  @override
  _OrderHistoryDetailsState createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails> {

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopId = (prefs.getString('shopId') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
      getOrdersHistory();
    });
  }

  loadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Map ordersHistoryData;
  List ordersHistoryList;
  String shopId, phoneNumber;

  int stackIndex = 0;

  Future getOrdersHistory() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getOrdersHistory.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      ordersHistoryList = null;
      stackIndex = 2;
    } else {
      ordersHistoryData = json.decode(response.body);
      setState(() {
        ordersHistoryList = ordersHistoryData['orders'];
        stackIndex = 1;
      });
      print(ordersHistoryList.toString());
    }
  }

  String parseTime(String dateTime) {
    String time = dateTime.substring(11, 16);
    String hr = time.substring(0, 2);
    String min = time.substring(3);
    String it;
    switch (hr) {
      case '13':
        it = '1:' + min + ' PM';
        break;
      case '14':
        it = '2:' + min + ' PM';
        break;
      case '15':
        it = '3:' + min + ' PM';
        break;
      case '16':
        it = '4:' + min + ' PM';
        break;
      case '17':
        it = '5:' + min + ' PM';
        break;
      case '18':
        it = '6:' + min + ' PM';
        break;
      case '19':
        it = '7:' + min + ' PM';
        break;
      case '20':
        it = '8:' + min + ' PM';
        break;
      case '21':
        it = '9:' + min + ' PM';
        break;
      case '22':
        it = '10:' + min + ' PM';
        break;
      case '23':
        it = '11:' + min + ' PM';
        break;
      case '24':
        it = '12:' + min + ' PM';
        break;
      default:
        it = hr + ':' + min + ' AM';
    }
    return it;
  }

  String parseDate(String dateTime) {
    String date = dateTime.substring(0, 10);
    String m = date.substring(5, 7);
    String d = date.substring(8);
    String y = date.substring(0, 4);
    String id;
    switch (m) {
      case '01':
        id = d + ' Jan ' + y;
        break;
      case '02':
        id = d + ' Feb ' + y;
        break;
      case '03':
        id = d + ' Mar ' + y;
        break;
      case '04':
        id = d + ' Apr ' + y;
        break;
      case '05':
        id = d + ' May ' + y;
        break;
      case '06':
        id = d + ' Jun ' + y;
        break;
      case '07':
        id = d + ' Jul ' + y;
        break;
      case '08':
        id = d + ' Aug ' + y;
        break;
      case '09':
        id = d + ' Sep ' + y;
        break;
      case '10':
        id = d + ' Oct ' + y;
        break;
      case '11':
        id = d + ' Nov ' + y;
        break;
      case '12':
        id = d + ' Dec ' + y;
        break;
      default:
        id = 'DD MM YYYY';
    }
    return id;
  }

  paidListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 1),
            blurRadius: 20,
            offset: Offset(0, 10),
          )
        ]),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          '#' + ordersHistoryList[index]['oid'],
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 2,
                              fontSize: 18,
                              color: Colors.blueGrey[900]),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        AutoSizeText(
                          ordersHistoryList[index]['name'],
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 2,
                              fontSize: 14,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        AutoSizeText(
                          parseDate(ordersHistoryList[index]['paidTime']) +
                              ', ' +
                              parseTime(ordersHistoryList[index]['paidTime']),
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 2,
                              fontSize: 12,
                              color: Colors.grey[600]),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () {
                          final number = ordersHistoryList[index]['phone'];
                          loadURL('tel:$number');
                        },
                      )),
                ],
              ),
            ],
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
        title: Text(
            'Order History',
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
      ),
      body:ListView.builder(
        itemBuilder: (context, index) {
          return paidListItems(index);
        },
        itemCount: ordersHistoryList == null
            ? 0
            : ordersHistoryList.length,
      ),
    );
  }
}
