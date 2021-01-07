import 'package:flutter/material.dart';
import 'package:grupp_8/models/constants.dart';

import '../welcome_view/welcome_screen_index.dart';
import '../home_view/home_screen_index.dart';

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
          title: Text("".toUpperCase()),
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
            image: AssetImage("assets/images/about_us.png"), fit: BoxFit.cover),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 175),
                child: Container(
                  //color: Colors.black.withOpacity(0.2),
                  alignment: Alignment.center,
                  child: Text(
                    'Hi! Thanks for using our flutter app.',
                    style: TextStyle(
                        color: Colors.grey[850],
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              Divider(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'This app was developed during a school project by six 3rd year students at Gothenburg University.',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Divider(),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Our app is powered by Unsplash API.',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Developers:',
                    style: TextStyle(
                        color: Colors.grey[800], fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Andreas Åsén \nEmil Engberg Svensson \nErik Frisenstam \nIsabelle Schafhauser \nCarl Engman \nEvelina Bragsjö',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Divider(
                height: 40,
              ),
              Container(
                height: 35,
                child: new Image.asset("assets/images/Unsplash_Logo_Full.png"),
              ),
            ],
          ),
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
      'Version: 1.0.0',
      style: TextStyle(fontSize: 12),
    ),
  );
}
