import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/orderhistorydetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  String shopId, phoneNumber;

  int stackIndex = 0;

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopId = (prefs.getString('shopId') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
      getOrdersHistory();
    });
  }

  Map ordersHistoryData;
  List ordersHistoryList;

  Future getOrdersHistory() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getOrdersHistory.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      ordersHistoryList = null;
      stackIndex=2;
    } else {
      ordersHistoryData = json.decode(response.body);
      setState(() {
        ordersHistoryList = ordersHistoryData['orders'];
        stackIndex=1;
      });
      print(ordersHistoryList.toString());
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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Order History',
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: IndexedStack(
        index: stackIndex,
        children: <Widget>[
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage('assets/images/loading.png'),
                    fit: BoxFit.contain)),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return paidListItems(index);
            },
            itemCount: ordersHistoryList == null ? 0 : ordersHistoryList.length,
          ),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage('assets/images/error.png'),
                    fit: BoxFit.contain)),
          ),
        ],
      )
    );
  }

  paidListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ()
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                OrderHistoryDetails(index,ordersHistoryList)));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.person,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child:AutoSizeText(
                        ordersHistoryList[index]['name'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.credit_card,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child:AutoSizeText(
                        'Order ID : ' + ordersHistoryList[index]['oid'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.message,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child:AutoSizeText(
                        'Status : ' + ordersHistoryList[index]['status'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
               /* SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.card_travel,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CarryBag : ' +
                            (ordersHistoryList[index]['isCarryBag'] == '1' ? 'Yes' : 'No'),
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.check_box_outline_blank,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CarryBag : ' +
                            (ordersHistoryList[index]['isCartonBox'] == '1' ? 'Yes' : 'No'),
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.timelapse,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child:AutoSizeText(
                        'Pickup Time : ' + ordersHistoryList[index]['userPickupTime'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.timelapse,color: Colors.grey[800],),
                    ),
                    Expanded(
                      flex: 8,
                      child:AutoSizeText(
                        'Paid Time : ' + ordersHistoryList[index]['paidTime'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
