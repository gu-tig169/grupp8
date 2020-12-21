import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'photo.dart';
import 'package:photo_view/photo_view.dart';
import 'package:like_button/like_button.dart';
import 'home_screen_view.dart';

// class FullScreen extends StatefulWidget {
//   final Photo heroTag;
//   FullScreen(this.heroTag);

//   @override
//   _FullScreenState createState() => _FullScreenState();
// }

// class _FullScreenState extends State<FullScreen> {
//   @override
//   initState() {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     SystemChrome.restoreSystemUIOverlays();
//     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               child: Center(
//                 child: Hero(
//                   tag: widget.heroTag.id,
//                   child: CachedNetworkImage(
//                     imageUrl: widget.heroTag.photoUrl,
//                     placeholder: null,
//                     errorWidget: null,
//                   ),
//                 ),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FullScreen extends StatefulWidget {
  final Photo photo;
  FullScreen(this.photo);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  initState() {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
            child: Stack(
          fit: StackFit.expand,
          children: [
            _photoView(),
            Positioned(
              child: _heartButton(),
              bottom: 110,
              right: 20,
            ),
            Positioned(
              child: _saveButton(),
              bottom: 30,
              right: 20,
            ),
            Positioned(
              child: _backButton(),
              top: 10,
              left: 10,
            ),
            Positioned(
              child: _shareButton(),
              top: 10,
              right: 10,
            ),
            Positioned.fill(
              top: 17,
              child: Align(
                alignment: Alignment.topCenter,
                child: _photographerName(),
              ),
            ),
            Positioned.fill(
              top: 40,
              child: Align(
                alignment: Alignment.topCenter,
                child: _photoLocation(),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _photoView() {
    return PhotoView.customChild(
      backgroundDecoration: BoxDecoration(color: Colors.black),
      basePosition: Alignment.center,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered,
      heroAttributes: PhotoViewHeroAttributes(tag: widget.photo.id),
      child: GestureDetector(
        child: CachedNetworkImage(
          imageUrl: widget.photo.photoUrl,
          placeholder: null,
          errorWidget: null,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _heartButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            color: Color.fromARGB(150, 59, 55, 55),
            width: 70,
            height: 70,
            child: LikeButton(
              padding: EdgeInsets.only(left: 4),
              onTap: onLikeButtonTapped,
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite_sharp,
                  color: isLiked ? Colors.redAccent : Colors.white,
                  size: 30,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: GestureDetector(
          onTap: () {
            print('test');
          },
          child: Container(
            color: Color.fromARGB(125, 255, 255, 255),
            width: 70,
            height: 70,
            child: Icon(
              CupertinoIcons.arrow_down,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => (HomeScreen())),
              );
      },
      child: Icon(
        CupertinoIcons.xmark,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _shareButton() {
    return GestureDetector(
      onTap: () {},
      child: Icon(
        CupertinoIcons.square_arrow_up,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _photographerName() {
    return Text(
      ('Photo by ' + widget.photo.user),
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }

  Widget _photoLocation() {
    if (widget.photo.location != null) {
      return Text((widget.photo.location),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ));
    } else
      return Text(('Unknown location'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ));
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    //När den tappas, gör något (typ spara i lista)?
    return !isLiked;
  }
}
