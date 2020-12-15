import 'package:flutter/material.dart';
import './home_screen.dart';

class PictureView extends StatefulWidget {

_PictureViewState createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(),
      body:  
        Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.infinity,
              child: Container( 
                height: 30.0,
                child: Image(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/chewy3.jpg'), // gör om detta till så att den lyssnar på vilken item den ska visa
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: 30,
                width: double.infinity,
                color: Colors.black,
              ),
            ), 
            Positioned(
              child: OverflowBox(
                minHeight: 0.0,
                minWidth: 0.0,
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black,
                  width: 400,
                  height: 60,
                ),
              ),
            ),   
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.share, 
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  print('Shared');
                },
              ),
                bottom: 5,
                left: 30,
            ),
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border_outlined, 
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  print('Liked');
                },
              ),
                bottom: 5,
                right: 30,
            ),
          ],
        ),
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
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
      title: Text(
          '*Picturetext*', 
          style: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.w400
          ),
      ),
    );
  }
}
