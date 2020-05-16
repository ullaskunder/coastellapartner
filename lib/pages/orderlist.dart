import 'package:auto_size_text/auto_size_text.dart';
import 'package:costellapartner/pages/vieworder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  Icon customIcon = Icon(
    Icons.search,
    size: 30,
  );
  Widget customSearchBar = AutoSizeText(
    'COASTELLA',
    style: GoogleFonts.nunitoSans(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    if (this.customIcon.icon == Icons.search) {
                      this.customIcon = Icon(Icons.cancel);
                      this.customSearchBar = TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              letterSpacing: 2,
                            )),
                        style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      this.customIcon = Icon(
                        Icons.search,
                        size: 30,
                      );
                      this.customSearchBar = AutoSizeText(
                        'COASTELLA',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      );
                    }
                  });
                },
                icon: customIcon,
              ),
            ],
            backgroundColor: Colors.grey[800],
            elevation: 0,
            title: customSearchBar,
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromRGBO(255, 255, 255, 0.2)),
              tabs: <Widget>[
                Tab(
                  text: 'NEW ORDERS',
                ),
                Tab(
                  text: 'PACKED ORDERS',
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: TabBarView(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (context, index) {
                    return newListItems(index);
                  },
                  itemCount: 5,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return packedListItems(index);
                  },
                  itemCount: 2,
                ),
              ],
            ),
          )),
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.shopping_cart,
                          size: 60,
                          color: Colors.grey[800],
                        )),
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
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            AutoSizeText(
                              'Order ID',
                              style: GoogleFonts.nunitoSans(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            AutoSizeText(
                              'Carry Bag Needed',
                              style: GoogleFonts.nunitoSans(
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            AutoSizeText(
                              'PickUp Time : 5:45 PM',
                              style: GoogleFonts.nunitoSans(
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: height * 0.05,
                      width: width * 0.24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[800],
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'CALL',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AudioApp()));
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
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[800],
                      ),
                      child: Center(
                        child: AutoSizeText(
                          'PACKED',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Icon(Icons.shopping_cart,
                  color: Colors.grey[800],
                  size: width*0.16,)
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
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        AutoSizeText(
                          'Order ID',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        AutoSizeText(
                          'Packed',
                          style: GoogleFonts.nunitoSans(
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
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
                          ],
                        ),
                      ],
                    ),
                  ),
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
