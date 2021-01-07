import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import 'components/slidingup_panel.dart';
import 'components/slidingup_body.dart';

// Class and builder for welcome view.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    focusNodeUsername.addListener(() {
      if (focusNodeUsername.hasFocus) {
        hintTextUsername = '';
      } else {
        hintTextUsername = 'Username';
      }
      setState(() {});
    });
    focusNodePassword.addListener(() {
      if (focusNodePassword.hasFocus) {
        hintTextPassword = '';
      } else {
        hintTextPassword = 'Password';
      }
      setState(() {});
    });
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
                  body: slidingupBody(context),
                  controller: pc,
                  panel: slidingupPanel(context),
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
}
