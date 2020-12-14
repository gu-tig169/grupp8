import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}
class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 75, 83), 
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {}
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,                      
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
              // image: DecorationImage(
              //  fit: BoxFit.cover,
              //    image: AssetImage('images/grupp8.png'),
                    ),
                  ),
             //  ),
              ],
            ),
          ],
        ),
      );
    }
  }

