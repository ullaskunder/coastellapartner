import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/textorder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:costellapartner/pages/imageorder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {


  @override
  void initState() {
    super.initState();
    getSP();
  }

  String shopId, phoneNumber;

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopId = (prefs.getString('shopId') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
      getNewOrders();
      getAcceptedOrders();
      getPackedOrders();
    });
  }

  Map newOrdersData, acceptedOrdersData, packedOrdersData;
  List newOrdersList, acceptedOrdersList, packedOrdersList;
  int newOrderIndex = 0, acceptedOrderIndex = 0, packedOrderIndex = 0;

  Future getNewOrders() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getNewOrders.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      newOrdersList = null;
    } else {
      newOrdersData = json.decode(response.body);
      setState(() {
        newOrdersList = newOrdersData['orders'];
        newOrderIndex = 1;
      });
      print(newOrdersList.toString());
    }
  }

  Future getAcceptedOrders() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getAcceptedOrders.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      acceptedOrdersList = null;
    } else {
      acceptedOrdersData = json.decode(response.body);
      setState(() {
        acceptedOrdersList = acceptedOrdersData['orders'];
        acceptedOrderIndex = 1;
      });
      print(acceptedOrdersList.toString());
    }
  }

  Future getPackedOrders() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getPackedOrders.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      packedOrdersList = null;
    } else {
      packedOrdersData = json.decode(response.body);
      setState(() {
        packedOrdersList = packedOrdersData['orders'];
        packedOrderIndex = 1;
      });
      print(packedOrdersList.toString());
    }
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

  void payOrder(int index) async {
    var url = 'http://coastella.in/coastellapartner/php/payOrder.php';
    Map data = {"oid": packedOrdersList[index]['oid']};

    var response = await http.post(url, body: data);
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('Payment succesfull');
        errorMessage('Payment succesfull');
      } else {
        print('Failed to pay order! Try again');
        errorMessage('Failed to pay order! Try again');
      }
    } else {
      print('Failed to pay order! Try again');
      errorMessage('Failed to pay order! Try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.grey[800],
              child: TabBar(
                isScrollable: true,
                  indicator: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2)),
                  tabs: <Widget>[
                    Tab(
                      text: 'NEW ORDERS',
                    ),
                    Tab(
                      text: 'ACCEPTED ORDERS',
                    ),
                    Tab(
                      text: 'PACKED ORDERS',
                    )
                  ],
                ),
            ),
          ),

          body: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
            child: TabBarView(
              children: <Widget>[
                IndexedStack(
                  index: newOrderIndex,
                  children: <Widget>[
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image: AssetImage('assets/images/error.png'),
                              fit: BoxFit.contain)),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return newListItems(index);
                      },
                      itemCount: newOrdersList == null ? 0 : newOrdersList.length,
                    ),
                  ],
                ),
                IndexedStack(
                  index: acceptedOrderIndex,
                  children: <Widget>[
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image: AssetImage('assets/images/error.png'),
                              fit: BoxFit.contain)),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return acceptedListItems(index);
                      },
                      itemCount: acceptedOrdersList == null
                          ? 0
                          : acceptedOrdersList.length,
                    ),
                  ],
                ),
                IndexedStack(
                  index: packedOrderIndex,
                  children: <Widget>[
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image: AssetImage('assets/images/error.png'),
                              fit: BoxFit.contain)),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return packedListItems(index);
                      },
                      itemCount:
                          packedOrdersList == null ? 0 : packedOrdersList.length,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  newListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        newOrdersList[index]['name'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                      child: Icon(
                        Icons.credit_card,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'OrderID : ' + newOrdersList[index]['oid'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                /*Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.card_travel,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CarryBag : ' +
                            (newOrdersList[index]['isCarryBag'] == '1'
                                ? 'Yes'
                                : 'No'),
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
                      child: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CartonBox : ' +
                            (newOrdersList[index]['isCartonBox'] == '1'
                                ? 'Yes'
                                : 'No'),
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
                ),*/
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.timelapse,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'Pickup Time : ' +
                            newOrdersList[index]['userPickupTime'],
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (newOrdersList[index]['orderType'] == 'text') {
                          print('yes');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TextOrder(index, newOrdersList)));
                        } else {
                          print('no');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ImageOrder(index, newOrdersList)));
                        }
                      },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'VIEW',
                            style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  acceptedListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        acceptedOrdersList[index]['name'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                      child: Icon(
                        Icons.credit_card,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'OrderID : ' + acceptedOrdersList[index]['oid'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                /*Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.card_travel,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CarryBag : ' +
                            (acceptedOrdersList[index]['isCarryBag'] == '1'
                                ? 'Yes'
                                : 'No'),
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
                      child: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CartonBox : ' +
                            (acceptedOrdersList[index]['isCartonBox'] == '1'
                                ? 'Yes'
                                : 'No'),
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
                ),*/
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.timelapse,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'Pickup Time : ' +
                            acceptedOrdersList[index]['userPickupTime'],
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (acceptedOrdersList[index]['orderType'] == 'text') {
                          print('yes');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TextOrder(index, acceptedOrdersList)));
                        } else {
                          print('no');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ImageOrder(index, acceptedOrdersList)));
                        }
                      },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'VIEW',
                            style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  packedListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        packedOrdersList[index]['name'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
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
                      child: Icon(
                        Icons.credit_card,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'OrderID : ' + packedOrdersList[index]['oid'],
                        style: GoogleFonts.nunitoSans(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                /*Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.card_travel,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CarryBag : ' +
                            (acceptedOrdersList[index]['isCarryBag'] == '1'
                                ? 'Yes'
                                : 'No'),
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
                      child: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'CartonBox : ' +
                            (acceptedOrdersList[index]['isCartonBox'] == '1'
                                ? 'Yes'
                                : 'No'),
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
                ),*/
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.timelapse,
                        color: Colors.grey[800],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: AutoSizeText(
                        'Pickup Time : ' +
                            packedOrdersList[index]['userPickupTime'],
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        print('paid');
                        payOrder(index);
                        },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'PAID',
                            style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
/*
 ToggleBar(
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                selectedTabColor: Color(0xffc62828),
                labels: ["New Orders", "Packed"],
                onSelectionUpdated: (index) => {} // Do something with index
                ),


 */
