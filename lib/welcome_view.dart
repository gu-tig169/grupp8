import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_screen.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PanelController _pc = new PanelController();

  final TextEditingController passwordInput = new TextEditingController();
  final TextEditingController usernameInput = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: 550,
            minHeight: 0,
            parallaxEnabled: false,
            body: _body(),
            controller: _pc,
            panel: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 0.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 86, 75, 83),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _userNameTextField(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _passwordTextField(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      logInButtonSlider(context),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      resetPassword(),
                    ],
                  ),
                ],
              ),
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            color: Color.fromARGB(255, 172, 171, 173),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/startview.png"),
              fit: BoxFit.cover)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            logoImage(),
            SizedBox(
              height: 425,
            ),
            loginButtonBody(),
            SizedBox(
              height: 10,
            ),
            registerButtonBody(),
            SizedBox(
              height: 20,
            ),
            unsplashLogo(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _userNameTextField() {
    return Container(
      margin: EdgeInsets.only(
        left: 60,
        right: 60,
        //top: 10,
      ),
      child: TextField(
        style: TextStyle(color: Color.fromARGB(255, 107, 90, 100)),
        cursorColor: Color.fromARGB(255, 107, 90, 100),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        obscureText: false,
        controller: usernameInput,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
          fillColor: Color.fromARGB(255, 196, 196, 196),
          filled: true,
          hintText: "Username",
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 107, 90, 100),
          ),
        ),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ]),
    );
  }

  Widget _passwordTextField() {
    return Container(
      margin: EdgeInsets.only(
        left: 60,
        right: 60,
        //top: 10,
      ),
      child: TextField(
        style: TextStyle(color: Color.fromARGB(255, 107, 90, 100)),
        cursorColor: Color.fromARGB(255, 107, 90, 100),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        obscureText: true,
        controller: passwordInput,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
          fillColor: Color.fromARGB(255, 196, 196, 196),
          filled: true,
          hintText: "Password",
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 107, 90, 100),
          ),
        ),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ]),
    );
  }

  Widget logInButtonSlider(context) {
    return Container(
      child: SizedBox(
        width: 185,
        height: 45,
        child: RaisedButton(
          elevation: 7.0,
          textColor: Color.fromARGB(255, 224, 234, 255),
          child: Text(
            "Log in",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          color: Color.fromARGB(255, 86, 75, 83),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: Color.fromARGB(255, 86, 75, 83))),
          onPressed: () {
            if (usernameInput.text != '' &&
                usernameInput.text != null &&
                passwordInput.text != '' &&
                passwordInput.text != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (HomeScreen())),
              );
            } else
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color.fromARGB(255, 86, 75, 83),
                    title: Text(
                        "Oops! Looks like you forgot your username and/or password!"),
                  );
                },
              );
          },
        ),
      ),
    );
  }

  Widget resetPassword() {
    return Container(
      child: TextButton(
        child: Text(
          "Reset password",
          style: TextStyle(
              decoration: TextDecoration.underline,
              color: Color.fromARGB(255, 107, 90, 100)),
        ),
        onPressed: () async {
          const url = 'https://unsplash.com/users/password/new';
          if (await canLaunch(url)) {
            await launch(url, forceWebView: true);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }

  Widget logoImage() {
    return Text(
      '''PLENTY 
OF PICS''',
      style: TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 3.0,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ],
          color: Color.fromARGB(255, 224, 234, 255),
          fontSize: 48,
          fontFamily: "Syncopate"),
    );
  }

  Widget loginButtonBody() {
    return Container(
      child: SizedBox(
        width: 185,
        height: 45,
        child: RaisedButton(
          elevation: 7.0,
          textColor: Color.fromARGB(255, 224, 234, 255),
          child: Text(
            "Log in",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          color: Color.fromARGB(255, 86, 75, 83),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: Color.fromARGB(255, 86, 75, 83))),
          onPressed: () => _pc.open(),
        ),
      ),
    );
  }

  Widget registerButtonBody() {
    return Container(
      child: SizedBox(
        width: 185,
        height: 45,
        child: FlatButton(
            textColor: Color.fromARGB(255, 51, 51, 51),
            child: Text(
              "Register",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            color: Color.fromARGB(75, 196, 196, 196),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                    color: Color.fromARGB(255, 86, 75, 83))),
            onPressed: () async {
              const url = 'https://unsplash.com/join';
              if (await canLaunch(url)) {
                await launch(url, forceWebView: true);
              } else {
                throw 'Could not launch $url';
              }
            }),
      ),
    );
  }

  Widget unsplashLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Powered by ",
            style: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 51, 51, 51))),
        Container(
          height: 15,
          child: new Image.asset("assets/images/Unsplash_Logo_Full.png"),
        ),
      ],
    );
  }
}
