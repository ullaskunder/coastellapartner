import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Order History',style: GoogleFonts.nunitoSans(
          letterSpacing: 1,
          color: Colors.white,
        ),),
        backgroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: ListView.builder(
          itemBuilder: (context,index)
              {
                return paidListItems(index);
              },itemCount: 8,
      ),
    );
  }
  paidListItems(index)
  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child:Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Icon(Icons.done,size: 50,color: Colors.grey[800],),
                    decoration: BoxDecoration(
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(
                          'Buyer Name',
                          style: GoogleFonts.nunitoSans(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        AutoSizeText(
                          'Order ID',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        AutoSizeText(
                          'Status : Paid',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        AutoSizeText(
                          'Paid Time : 5:50 PM',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        AutoSizeText(
                          'Order Date : 15-05-2020',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
