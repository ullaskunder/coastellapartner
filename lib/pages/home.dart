import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/inventory.dart';
import 'package:costellapartner/pages/orderlist.dart';
import 'package:costellapartner/pages/profile.dart';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  final pages = [
    InventoryPage(),
    OrderListPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey,
        index: currentIndex,
        items: <Widget>[
          Icon(Icons.settings,),
          Icon(Icons.list,),
          Icon(Icons.perm_identity,),
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
