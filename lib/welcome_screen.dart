import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.tealAccent, 
            body: background(context)));
  }

  Widget background(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/startview.png"),
              fit: BoxFit.cover)),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            logInButton(context),
            registerButton(),
          ],
        ),
      ),
    );
  }

  Widget logInButton(context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 15,
      ),
      child: Transform.scale(
        scale: 6,
        child: IconButton(
            icon: Image.asset("assets/images/logInButton.png"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (LoginScreen())),
              );
            }),
      ),
    );
  }

  Widget registerButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Transform.scale(
        scale: 6,
        child: IconButton(
            icon: Image.asset("assets/images/registerButton.png"),
            onPressed: () async {
        const url = 'https://unsplash.com/join';
        if (await canLaunch(url)) {
          await launch(url, forceWebView: true);
        } else {
          throw 'Could not launch $url';}
    
            }
          ),
      ),
    );
  }
}

