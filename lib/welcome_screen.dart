import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.tealAccent,
        body: background(context)
      )
    );
  }

  Widget background(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/framsida.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              registerButton(),
              logInButton(),
            ],
          ),
      );
    
  }

  Widget registerButton() {
    return FlatButton.icon(
      onPressed: () {},
      label: Text("REGISTER"),
      icon: Icon(Icons.radio_button_on_outlined),
    );
  }
    Widget logInButton() {
    return FlatButton.icon(
      onPressed: () {},
      label: Text("LOGIN"),
      icon: Icon(Icons.radio_button_on_outlined),
    );
  }
}
