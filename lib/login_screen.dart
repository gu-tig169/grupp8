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
              image: AssetImage("assets/images/framsida.png"),
              fit: BoxFit.cover)),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              if (usernameInput.text != '' && usernameInput.text != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (HomeScreen())),
                );
              }
            }),
      ),
    );
  }
}
