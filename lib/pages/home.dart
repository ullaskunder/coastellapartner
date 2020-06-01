import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/inventory.dart';
import 'package:costellapartner/pages/orderlist.dart';
import 'package:costellapartner/pages/profiledetail.dart';
import 'package:costellapartner/pages/orderhistory.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  final pages = [
    InventoryPage(),
    OrderListPage(),
    OrderHistory(),
    ProfileDetail(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.more_horiz,color: Colors.grey[900],),
            title: new Text('Utilities',style: TextStyle(color: Colors.grey[900],)),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,color: Colors.grey[900],),
            title: new Text('Home',style: TextStyle(color: Colors.grey[900],)),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.access_time,color: Colors.grey[900],),
            title: new Text('History',style: TextStyle(color: Colors.grey[900],)),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.grey[900],),
              title: Text('Profile',style: TextStyle(color: Colors.grey[900],)),
            backgroundColor: Colors.white,
          )
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
