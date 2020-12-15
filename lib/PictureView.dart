import 'package:flutter/material.dart';
import './home_screen.dart';

class PictureView extends StatefulWidget {

_PictureViewState createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 75, 83),
      appBar: _appBar(),
      body:  
        Stack(
          children: [
            Container(
              height: 588,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Image(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                image: AssetImage('assets/images/chewy1.jpg'), // gör om detta till så att den lyssnar på vilken item den ska visa
              ),
            ),
            Positioned(
              child: Text(
                '*Picturetext*', 
                style: TextStyle(
                  fontSize: 18, 
                  color: Colors.white
                ),
              ),
              bottom: 15,
              left: 10,
            ),
            Positioned( 
              child: Icon(
                Icons.circle, 
                color: Colors.grey[900], // Går inte att lägga in ARGB färgen här. Försöka lösa en variabel på färgen i hexkod
                size: 60,
              ),
              bottom: 15,
              right: 15,
            ),
            Positioned(
              child: Icon(
                Icons.favorite_border_outlined, // Borde kanske göra om dessa till en Iconbutton istället
                color: Colors.white,
                size: 22,
                ),
                bottom: 33,
                right: 35,
            ),
          ],
        ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading:
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (HomeScreen())),
            );
          },
        ),
    );
  }
}
