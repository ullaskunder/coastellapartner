import 'package:costellapartner/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:costellapartner/pages/login.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/inventory.dart';
import 'package:costellapartner/pages/orderlist.dart';
import 'package:costellapartner/pages/profile.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/login':(context) => LoginPage(),
    '/splash':(context) => SplashPage(),
    '/home':(context) => HomePage(),
    '/orderlist':(context) => OrderListPage(),
    '/profile':(context) => ProfilePage(),
    '/inventory':(context) => InventoryPage(),
  },
));
