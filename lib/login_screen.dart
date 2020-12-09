import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: background(context)));
  }

  final TextEditingController passwordInput = new TextEditingController();
  final TextEditingController usernameInput = new TextEditingController();

  Widget background(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/blurredbg.png"),
              fit: BoxFit.cover)),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 330, top: 20),
              child: Column(
                children: [
                  buttonBack(context)
                ],
              )
            ),
            _userNameTextField(),
            _passwordTextField(),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [logInButton(context)],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _userNameTextField() {
    return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: TextField(
          controller: usernameInput,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30, width: 2)),
              hintText: "Username"),
        ));
  }

  Widget _passwordTextField() {
    return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: TextField(
          obscureText: true,
          controller: passwordInput,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30, width: 2)),
              hintText: "Password"),
        ));
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
              if (usernameInput.text != '' && usernameInput.text != null
                 && passwordInput.text != '' && passwordInput.text != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (HomeScreen())),
                );
              }
              else showDialog(context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Oops! Looks like you forgot your username and/or password!"),
                );
              });
            }
        ),
      ),
    );
  }
  Widget buttonBack(context) {
    return FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back),
    );
  }
}
