import 'package:flutter/material.dart';
import 'package:grupp_8/constants.dart';
import 'welcome_view.dart';
import 'home_screen_view.dart';

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
          title: Text("God Jul".toUpperCase()),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pic_3.jpg"),
                fit: BoxFit.cover),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     Padding(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              //       child: Container(
              //         height: size.width / 2,
              //         decoration: BoxDecoration(
              //           color: Colors.black.withOpacity(0.75),
              //         ),
              //         child: _aboutParagraph(),
              //       ),
              //     )
              //   ],
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     // Padding(
              //     //   padding: const EdgeInsets.symmetric(
              //     //       vertical: kDefaultPadding * 4),
              //     //   child: Container(
              //     //     padding: EdgeInsets.all(10.0),
              //     //     width: MediaQuery.of(context).size.width / 2.5,
              //     //     height: MediaQuery.of(context).size.width / 2.5,
              //     //     decoration: BoxDecoration(
              //     //       border: Border.all(color: Colors.white, width: 5),
              //     //       shape: BoxShape.circle,
              //     //       color: Colors.white,
              //     //       image: DecorationImage(
              //     //         fit: BoxFit.cover,
              //     //         image: AssetImage('assets/images/grupp8.png'),
              //     //       ),
              //     //     ),
              //     //   ),
              //     // ),

              //     _aboutParagraph(),
              //   ],
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  logoutButton(context),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: appVerText(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _aboutParagraph() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 6),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "About us\n".toUpperCase(),
              ),
              TextSpan(
                text: "Vi är grupp 8.\n",
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget logoutButton(context) {
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

Widget appVerText() {
  return Container(
    //alignment: Alignment.bottomCenter,

    child: Text(
      'Version: 0.1.5-alpha',
      style: TextStyle(fontSize: 12),
    ),
  );
}
