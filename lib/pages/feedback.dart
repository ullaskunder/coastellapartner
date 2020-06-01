import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController subject = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getSP();
  }

  @override
  void dispose() {
    super.dispose();
    subject.dispose();
  }

  String shopId;

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      shopId = (prefs.getString('shopId') ?? '');
    });
    print('Shop Id : ' + shopId);
  }

  void submitFeedback() async {
    String feedbackSubject = subject.text;

    var url = 'http://coastella.in/coastellapartner/php/feedback.php';
    Map data = {"title": 'Shop Feedback', "subject": feedbackSubject,"shopid":shopId};

    var response = await http.post(url, body: data);
    String status = response.body;
    print(status);
    if (response.statusCode == 200) {
      if (status == 'success;') {
        print('feedback submitted');
        errorMessage('Feedback Submitted succesfully');
      } else {
        print('Feedback Submission Failed');
        errorMessage('Feedback Submission Failed! Try again');
      }
    } else {
      print('Feedback Submission Failed');
      errorMessage('Feedback Submission Failed! Try again');
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
                        builder: (BuildContext context) => FeedBackPage()))
                  },
                )
              ],
            );
          });
    }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Feedback',
        style: GoogleFonts.nunitoSans(
          letterSpacing: 1,
          color: Colors.white,
        ),),
        elevation: 0,
          backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: width,
                height: height*0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/feedback.png'),
                    fit: BoxFit.contain,
                  )
                ),
              ),
              Container(
                width: width,
                height: height*0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          blurRadius: 20,
                          offset: Offset(0, 10))
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: subject,
                    style: GoogleFonts.nunitoSans(
                      letterSpacing: 1,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                        hintStyle: GoogleFonts.nunitoSans(
                          letterSpacing: 1,
                          color: Colors.grey,
                        )
                    ),
                    maxLines: 100,
                  ),
                ),
              ),
              SizedBox(height: height*0.02,),
              GestureDetector(
                  onTap: (){
                    submitFeedback();
                    print('Submit');
                    },
                  child: Container(
                    height: height*0.1,
                    decoration: BoxDecoration(
                        color: Colors.green[800],
                    ),
                    child: Center(
                      child: AutoSizeText(
                        'SUBMIT',
                        style: GoogleFonts.nunitoSans(
                            letterSpacing: 2,
                            color: Colors.white,
                            fontSize: 18
                        ),
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
