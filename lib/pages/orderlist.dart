import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/splash.dart';
import 'package:costellapartner/pages/textorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:costellapartner/pages/imageorder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

//this is the name given to the background fetch
var simplePeriodicTask = '1';
// flutter local notification setup
void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(0, 'Hey, Coastella Partner', '$v', platform,
      payload: 'VIS \n $v');
}

Future<void> begin() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher,
      isInDebugMode:
          true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15),
      //when should it check the link
      initialDelay: Duration(seconds: 5),
      //duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
    Map data = {'shopid': simplePeriodicTask};
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/notify.php',
        body: data);
    if (response.body.toString() == '' || response.body.toString() == 'no') {
    } else {
      showNotification(response.body.toString(), flp);
    }
    return Future.value(true);
  });
}

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  String shopId, phoneNumber;
  TextEditingController totalCost = new TextEditingController();

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopId = (prefs.getString('shopId') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
      getNewOrders();
      getAcceptedOrders();
      getPackedOrders();
      begin();
    });
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

  Map newOrdersData, acceptedOrdersData, packedOrdersData;
  List newOrdersList, acceptedOrdersList, packedOrdersList;
  int newOrderIndex = 0, acceptedOrderIndex = 0, packedOrderIndex = 0;

  Future getNewOrders() async {
    http.Response response = await http.post(
        'http://coastella.in/coastellapartner/php/getNewOrders.php',
        body: {'shopid': shopId});
    if (response.body.toString() == 'no') {
      newOrdersList = null;
      print(shopId);
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

  void payOrder(int index, String cost) async {
    var url = 'http://coastella.in/coastellapartner/php/payOrder.php';
    Map data = {"oid": packedOrdersList[index]['oid'], "totalCost": cost};

    var response = await http.post(url, body: data);
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('Payment successful');
        errorMessage('Payment successful');
      } else {
        print('Failed to pay order! Try again');
        errorMessage('Failed to pay order! Try again');
      }
    } else {
      print('Failed to pay order! Try again');
      errorMessage('Failed to pay order! Try again');
    }
  }

  void getTextFieldData(int index) {
    if (totalCost.text.isEmpty) {
      errorMessage('Enter the amount');
      print('Enter phone number');
    } else {
      String cost = totalCost.text;
      payOrder(index, cost);
      print(totalCost.text);
    }
  }

  Widget showPaymentForm(int index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
            width: width,
            height: height * 0.4,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.cancel),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextField(
                    controller: totalCost,
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 2,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Total Cost',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      getTextFieldData(index);
                    },
                    child: Container(
                      width: width,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.green[900],
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'PAY',
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
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.blueGrey[900],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.blueGrey[900],
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
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
                          color: Colors.blueGrey[900],
                          image: DecorationImage(
                              image: AssetImage('assets/images/error.png'),
                              fit: BoxFit.contain)),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return newListItems(index);
                      },
                      itemCount:
                          newOrdersList == null ? 0 : newOrdersList.length,
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
                          color: Colors.blueGrey[900],
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
                          color: Colors.blueGrey[900],
                          image: DecorationImage(
                              image: AssetImage('assets/images/error.png'),
                              fit: BoxFit.contain)),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return packedListItems(index);
                      },
                      itemCount: packedOrdersList == null
                          ? 0
                          : packedOrdersList.length,
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
    return GestureDetector(
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
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          width: width,
          height: height * 0.14,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image(
                    image: AssetImage('assets/images/cart.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          newOrdersList[index]['name'],
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1, fontSize: 16),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        AutoSizeText(
                          '#' + newOrdersList[index]['oid'],
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1, fontSize: 16),
                        ),
                      ],
                    )),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  acceptedListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
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
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          width: width,
          height: height * 0.14,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image(
                    image: AssetImage('assets/images/cart.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          acceptedOrdersList[index]['name'],
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1, fontSize: 16),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        AutoSizeText(
                          '#' + acceptedOrdersList[index]['oid'],
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 1, fontSize: 16),
                        ),
                      ],
                    )),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  packedListItems(index) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        width: width,
        height: height * 0.14,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage('assets/images/cart.png'),
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        packedOrdersList[index]['name'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 16),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        '#' + packedOrdersList[index]['oid'],
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 12),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      AutoSizeText(
                        parseDate(packedOrdersList[index]['userPickupTime']) +
                            ', ' +
                            parseTime(
                                packedOrdersList[index]['userPickupTime']),
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 1, fontSize: 12),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showPaymentForm(index);
                        });
                  },
                  child: AutoSizeText(
                    'PAY',
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 1,
                      color: Colors.amber[900],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
