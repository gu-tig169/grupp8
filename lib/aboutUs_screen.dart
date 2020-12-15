import 'package:flutter/material.dart';
import 'welcome_view.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}
class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 75, 83), 
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {}
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "ABOUT US",
                    style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,                      
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width/2.5,
                  height: MediaQuery.of(context).size.width/2.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                 image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/chewy1.jpg'),
                    ),
                  ),
               ),
              _aboutParagraph(),
              logoutButtonBody(context),
              appVerText(),
              ],
            ),
          ],
        ),
      );
    }
  }

Widget _aboutParagraph() {
return Container(
  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
    child: RichText(
    text: TextSpan(
     children: <TextSpan>[
      TextSpan(
        text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ',
         style: TextStyle(
          fontSize: 18.0,
          letterSpacing: 1.5,
        ),
       ),
     ],
   ),
  ),
 );
}

Widget logoutButtonBody(context) {
  return Container(
    padding: EdgeInsets.only(top: 35.0),
    child: SizedBox(
      width: 185,
      height: 45,
      child: RaisedButton(
        elevation: 7.0,
        textColor: Color.fromARGB(255, 224, 234, 255),
        child: Text(
          "Log out",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        color: Color.fromARGB(255, 107, 90, 100),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            side: BorderSide(color: Color.fromARGB(255, 86, 75, 83))),
            onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => (WelcomeView())),
                    );
                  },
        ),
      ),
    );
  }

Widget appVerText() {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: EdgeInsets.only(top: 15.0),
    child: Text(
      'APP VER 0.0.0'
    ),
  );
}