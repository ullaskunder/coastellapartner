import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:costellapartner/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ImageOrder extends StatefulWidget {
  final int index;
  final List data;

  ImageOrder(this.index, this.data, {Key key}) : super(key: key);

  @override
  _ImageOrderState createState() => _ImageOrderState();
}

class _ImageOrderState extends State<ImageOrder> {
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
    Map data = {"oid": widget.data[widget.index]['oid']};

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
    Map data = {"oid": widget.data[widget.index]['oid']};

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
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          '#' + widget.data[widget.index]['oid'],
          style: GoogleFonts.nunitoSans(
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                width: width,
                height: height * 0.6,
                imageUrl: (widget.data[widget.index]['orderList']).toString(),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                decoration: BoxDecoration(color: Colors.white,),
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
                                 widget.data[widget.index]['name'],
                                 style: GoogleFonts.nunitoSans(
                                   letterSpacing: 2,
                                   fontSize: 18,
                                 ),
                               ),
                               SizedBox(height: height*0.01,),
                               AutoSizeText(
                                 widget.data[widget.index]['address'],
                                 style: GoogleFonts.nunitoSans(
                                   letterSpacing: 2,
                                   fontSize: 14,
                                 ),
                                 maxLines: 3,
                               ),
                             ],
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child:IconButton(
                             icon: Icon(Icons.call),
                             onPressed: ()
                             {
                               final number = widget.data[widget.index]['phone'];
                               loadURL('tel:$number');
                             },
                           )
                         ),
                       ],
                     ),
                      Divider(height: 20,),
                     Row(
                       children: <Widget>[
                         Expanded(
                           flex: 1,
                           child: AutoSizeText(
                             'Packing\n' + widget.data[widget.index]['packingType'],
                             textAlign: TextAlign.center,
                             style: GoogleFonts.nunitoSans(
                               letterSpacing: 1,
                               color: Colors.green[900],
                             ),
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child: AutoSizeText(
                               'Delivery\n' + widget.data[widget.index]['deliveryType'],
                             textAlign: TextAlign.center,
                             style: GoogleFonts.nunitoSans(
                               letterSpacing: 1,
                               color: Colors.amber[900],
                             ),
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child: AutoSizeText(
                             'Pickup Time\n' + parseTime(widget.data[widget.index]['userPickupTime']),
                             textAlign: TextAlign.center,
                             style: GoogleFonts.nunitoSans(
                               letterSpacing: 1,
                               color: Colors.blue[900],
                             ),
                           ),
                         ),
                       ],
                     ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.02,),
              Container(
                width: width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: AutoSizeText(
                    'Buyer Comment\n' + widget.data[widget.index]['userComment'],
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 1,
                      fontSize: 14,
                      color: Colors.blueGrey[900]
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.02,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: ()
                      {
                        acceptOrder();
                      },
                      child: Container(
                        height: height*0.08,
                        color: Colors.green,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.done,color: Colors.white,),
                            AutoSizeText(' ACCEPT',style: GoogleFonts.nunitoSans(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 18
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: ()
                      {
                        packOrder();
                      },
                      child: Container(
                        height: height*0.08,
                        color: Colors.orange,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.shopping_basket,color: Colors.white,),
                            AutoSizeText(' PACK',style: GoogleFonts.nunitoSans(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 18
                            ),)
                          ],
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

  String parseTime(String dateTime)
  {
    String time = dateTime.substring(11,16);
    String hr = time.substring(0,2);
    String min = time.substring(3);
    String it;
    switch(hr)
    {
      case '13': it = '1:'+min+' PM';
      break;
      case '14': it = '2:'+min+' PM';
      break;
      case '15': it = '3:'+min+' PM';
      break;
      case '16': it = '4:'+min+' PM';
      break;
      case '17': it = '5:'+min+' PM';
      break;
      case '18': it = '6:'+min+' PM';
      break;
      case '19': it = '7:'+min+' PM';
      break;
      case '20': it = '8:'+min+' PM';
      break;
      case '21': it = '9:'+min+' PM';
      break;
      case '22': it = '10:'+min+' PM';
      break;
      case '23': it = '11:'+min+' PM';
      break;
      case '24': it = '12:'+min+' PM';
      break;
      default : it = hr+':'+min+' AM';

    }
    return it;
  }
}
