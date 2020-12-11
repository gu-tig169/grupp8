import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            
             color: Color.fromARGB(255, 86, 75, 83),
             child: Center(

               child: Text('Det är vi som är projektgrupp 8')
             )
  
          ),
          Positioned(
            child: AppBar(
              backgroundColor: Colors.transparent,
            ),
          ),
        ]
      )
    );
  }
}