import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderHistoryDetails extends StatefulWidget {
  final int index;
  final List data;

  OrderHistoryDetails(this.index, this.data, {Key key}) : super(key: key);

  @override
  _OrderHistoryDetailsState createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails> {

  loadURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
          padding: EdgeInsets.fromLTRB(10,10,10,40),
          child: Column(
            children: <Widget>[
              Container(
                width: width,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: Icon(Icons.history,color: Colors.grey[800],size: width*0.26,)),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.person),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              widget.data[widget.index]['name'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.location_on),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              widget.data[widget.index]['address'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.phone),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              widget.data[widget.index]['phone'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.card_travel),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              'Carry Bag : ' + (widget.data[widget.index]['isCarryBag'] == '1' ? 'Yes' : 'No'),
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.check_box_outline_blank),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              'Carton Box : ' + (widget.data[widget.index]['isCartonBox'] == '1' ? 'Yes' : 'No'),
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.timelapse),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              'Pickup Time : ' + widget.data[widget.index]['userPickupTime'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.timelapse),
                          ),
                          Expanded(
                            flex: 8,
                            child: AutoSizeText(
                              'Paid Time : ' + widget.data[widget.index]['paidTime'],
                              style: GoogleFonts.nunitoSans(
                                  letterSpacing: 1,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.04,),
              GestureDetector(
                onTap: () {
                  final number = widget.data[widget.index]['phone'];
                  loadURL('tel:$number');
                },
                child: Container(
                  height: height * 0.08,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            blurRadius: 20,
                            offset: Offset(0, 10))
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
            ],
          ),
        ),
      ),
    );
  }
}
