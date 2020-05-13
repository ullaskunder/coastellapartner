import 'package:costellapartner/pages/home.dart';
import 'package:costellapartner/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String val;

  Future<bool> isLoggedIn() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      val = (prefs.getString('login')??'');
    });
    print('login : ' + val);
    await Future.delayed(Duration(seconds: 2));
    if(val == 'done')
      return true;
    else
      return false;
  }

  void navigateToHome()
  {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage()
        )
    );
  }

  void navigateToLogin()
  {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage()
      )
    );
  }

  @override
  void initState(){
    super.initState();
    isLoggedIn().then((value)
        {
          if(value)
            {
              navigateToHome();
            }
          else
            {
              navigateToLogin();
            }

        }

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
           Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [
                   Colors.redAccent,
                   Colors.red,
                 ]
               )
             ),
           ),
            Shimmer.fromColors(
                child: Container(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    'Costella',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 60,
                     /* shadows: <Shadow>[
                        Shadow(
                          blurRadius: 18,
                          color: Colors.black87,
                          offset: Offset.fromDirection(120,10)
                        )
                      ]*/
                    ),
                  ),
                ),
                baseColor: Colors.white,
                highlightColor: Colors.red)
          ],
        ),
      ),
    );
  }

}
