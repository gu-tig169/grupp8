import 'package:flutter/material.dart';
import 'home_screen_view.dart';
import 'package:like_button/like_button.dart';

class PictureView extends StatefulWidget {
  _PictureViewState createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(),
      body: _pictureView(),
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => (HomeScreen())),
          );
        },
      ),
      title: Text(
        '*Picturetext*',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _pictureView() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            height: 30.0,
            child: Image(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              image: AssetImage(
                  'assets/images/grupp8.png'), // gör om detta till så att den lyssnar på vilken item den ska visa
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
              width: 4000,
              height: 60,
            ),
          ),
        ),
        Positioned(
          child: _shareIcon(),
          bottom: 5,
          left: 30,
        ),
        Positioned(
          child: _heartButton(),
          bottom: 17,
          right: 35,
        ),
      ],
    );
  }

  Widget _shareIcon() {
    return IconButton(
      icon: Icon(
        Icons.share,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () {
        print('Shared');
      },
    );
  }

//Kolla om man kan ta bort effekten för cirklarna runt om LikeButton. Annars, modifiera dem så att det passar UI.
  Widget _heartButton() {
    return LikeButton(
      size: 25.0,
      onTap: onLikeButtonTapped,
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite_sharp,
          color: isLiked ? Colors.redAccent : Colors.white,
          size: 30.0,
        );
      },
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    //När den tappas, gör något (typ spara i lista)?
    return !isLiked;
  }

//Har kvar denna om vi vill byta tillbaka till outlined-hjärta
  /* Widget _heartIcon() {
    return IconButton(

      icon: Icon(
        Icons.favorite_border_outlined, 
        color: Colors.white,
        size: 25,
      ),
      onPressed: () {
        print('Liked');
      },
    );
  }*/

}
