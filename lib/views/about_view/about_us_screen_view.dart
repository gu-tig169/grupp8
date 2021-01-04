import 'package:flutter/material.dart';
import 'package:grupp_8/models/constants.dart';

import '../welcome_view/welcome_view.dart';
import '../home_view/home_screen_view.dart';

// (Currently) UI for the About Us page.

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[850],
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
          title: Text("about us".toUpperCase()),
          centerTitle: true,
        ),
        body: _body(context, size),
      ),
    );
  }

  Container _body(BuildContext context, Size size) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/about_us.jpg"), fit: BoxFit.cover),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _logoutButton(context),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: _appVerText(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _logoutButton(context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
    child: SizedBox(
      width: 185,
      height: 45,
      child: RaisedButton(
        elevation: 7.0,
        textColor: Colors.black,
        child: Text(
          "Log out",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        color: Color.fromARGB(255, 196, 196, 196),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color.fromARGB(255, 86, 75, 83))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => (HomePage())),
          );
        },
      ),
    ),
  );
}

Widget _appVerText() {
  return Container(
    child: Text(
      'Version: 0.2.0',
      style: TextStyle(fontSize: 12),
    ),
  );
}
