import 'package:flutter/material.dart';
import 'aboutUs_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
             color: Color.fromARGB(255, 86, 75, 83),
  
          ),

          Positioned(
            child: AppBar(
              backgroundColor: Colors.transparent,
              actions: <Widget> [
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => (AboutUs())),
                    );
                  },
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                    },
                  )
              ]
            ),
          ),
        ],
      )
    );
    
  }
}
