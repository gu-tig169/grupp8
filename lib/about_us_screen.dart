import 'package:flutter/material.dart';
import 'welcome_view.dart';
import 'home_screen_view.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 49, 41, 47),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => (HomeScreen())),
                );
              },
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
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/grupp8.png'),
                      ),
                    ),
                  ),
                  _aboutParagraph(),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: logoutButton(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: appVerText(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            text: 'Vi är grupp 8 och vi är best flutter grupp.',
            style: TextStyle(
              fontSize: 16.0,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget logoutButton(context) {
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
      'Version: 0.1.5-alpha',
      style: TextStyle(fontSize: 12),
    ),
  );
}
