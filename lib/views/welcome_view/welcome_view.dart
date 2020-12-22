import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../home_view/home_screen_view.dart';

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
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              KeyboardAvoider(
                child: SlidingUpPanel(
                  maxHeight: 336,
                  minHeight: 0,
                  parallaxEnabled: false,
                  body: _body(),
                  controller: _pc,
                  panel: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
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
                          height: 20,
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
                  color: Colors.grey[850],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/startview.jpg"),
            fit: BoxFit.cover),
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            top: 75,
            child: Align(
              alignment: Alignment.topCenter,
              child: logoImage(),
            ),
          ),
          Positioned.fill(
            bottom: 180,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: loginButtonBody(),
            ),
          ),
          Positioned.fill(
            bottom: 125,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: registerButtonBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userNameTextField() {
    return Container(
      margin: EdgeInsets.only(
        left: 60,
        right: 60,
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
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
          fillColor: Colors.blueGrey[700],
          filled: true,
          hintText: "Username",
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black45,
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
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
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
          fillColor: Colors.blueGrey[700],
          filled: true,
          hintText: "Password",
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ]),
    );
  }

  Widget logInButtonSlider(context) {
    return Container(
      child: SizedBox(
        width: 150,
        height: 45,
        child: RaisedButton(
          elevation: 7.0,
          textColor: Colors.black,
          child: Text(
            "Log in",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          color: Color.fromARGB(255, 196, 196, 196),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.black,
            ),
          ),
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
                  return CupertinoAlertDialog(
                    title: Text("Oops!"),
                    content: Text(
                        " Looks like you forgot your username and/or password!"),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: Text(
                          "Try again",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
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
            color: Colors.white70,
          ),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          child: SizedBox(
            width: 185,
            height: 45,
            child: RaisedButton(
              elevation: 7.0,
              textColor: Colors.white,
              child: Text(
                "Log in",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              color: Color.fromARGB(150, 59, 55, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
              onPressed: () => _pc.open(),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButtonBody() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          child: SizedBox(
            width: 185,
            height: 45,
            child: FlatButton(
                textColor: Colors.black,
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                color: Color.fromARGB(125, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide.none,
                ),
                onPressed: () async {
                  const url = 'https://unsplash.com/join';
                  if (await canLaunch(url)) {
                    await launch(url, forceWebView: true);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget unsplashLogo() {
    return Container(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Powered by ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 37,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Container(
              height: 14,
              child: new Image.asset("assets/images/Unsplash_Logo_Full.png"),
            ),
          ),
        ],
      ),
    );
  }
}
