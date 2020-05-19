import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController title = new TextEditingController();
  TextEditingController subject = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    subject.dispose();
  }

  void submitFeedback() async {
    String feedbackTitle = title.text;
    String feedbackSubject = subject.text;

    var url = 'http://coastella.in/coastellapartner/php/feedback.php';
    Map data = {"title": feedbackTitle, "subject": feedbackSubject};

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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Feedback',
        style: GoogleFonts.nunitoSans(
          letterSpacing: 1,
          color: Colors.white,
        ),),
        elevation: 0,
          backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
             Container(
               width: width,
               height: height*0.1,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
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
                   controller: title,
                   style: GoogleFonts.nunitoSans(
                     letterSpacing: 1,
                   ),
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     hintText: 'Title',
                     hintStyle: GoogleFonts.nunitoSans(
                       letterSpacing: 1,
                       color: Colors.grey,
                     )
                   ),
                   maxLines: 1,
                 ),
               ),
             ),
              SizedBox(height: height*0.02,),
              Container(
                width: width,
                height: height*0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                        hintText: 'Subject',
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
              Padding(
                padding: EdgeInsets.fromLTRB(20,0,20,10),
                child: GestureDetector(
                  onTap: (){
                    submitFeedback();
                    print('Submit');
                    },
                  child: Container(
                    height: height*0.1,
                    width: width*0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey[800],
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
