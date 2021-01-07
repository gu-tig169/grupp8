import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grupp_8/views/home_view/home_screen_index.dart';
import 'package:url_launcher/url_launcher.dart';

FocusNode focusNodeUsername = FocusNode();
String hintTextUsername = 'Username';

FocusNode focusNodePassword = FocusNode();
String hintTextPassword = 'Password';

final TextEditingController passwordInput = new TextEditingController();
final TextEditingController usernameInput = new TextEditingController();

// Sliding up panel content elements.

Widget slidingupPanel(context) {
  return Center(
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
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
            _logInButtonSlider(context),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _resetPassword(),
          ],
        ),
      ],
    ),
  );
}

// Widgets for sliding up panel.

Widget _userNameTextField() {
  return Container(
    margin: EdgeInsets.only(
      left: 60,
      right: 60,
    ),
    child: TextField(
      focusNode: focusNodeUsername,
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
          ),
        ),
        fillColor: Colors.blueGrey[700],
        filled: true,
        hintText: hintTextUsername,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70.withOpacity(0.42069),
        ),
      ),
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ],
    ),
  );
}

Widget _passwordTextField() {
  return Container(
    margin: EdgeInsets.only(
      left: 60,
      right: 60,
    ),
    child: TextField(
      focusNode: focusNodePassword,
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
        hintText: hintTextPassword,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white70.withOpacity(0.42069),
        ),
      ),
    ),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 7,
          offset: const Offset(0, 5),
        )
      ],
    ),
  );
}

Widget _logInButtonSlider(context) {
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

Widget _resetPassword() {
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
