import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: background(),
    );
  }

  Widget background() {
    return
        //Image(image: AssetImage('assets/images/framsida.png'));
        Text("Hej!");
  }
}
