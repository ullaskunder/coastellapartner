import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TCPage extends StatefulWidget {
  @override
  _TCPageState createState() => _TCPageState();
}

class _TCPageState extends State<TCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('T & C',
        style: GoogleFonts.nunitoSans(
          letterSpacing: 2,
          color: Colors.white,
        ),
        ),
        elevation: 0,
          backgroundColor: Colors.blueGrey[900],
      ),
    );
  }
}
