import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grupp_8/models/photo.dart';
import 'package:photo_view/photo_view.dart';
import 'package:like_button/like_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home_view/home_screen_index.dart';

class FullScreen extends StatefulWidget {
  final Photo photo;
  FullScreen(this.photo);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Stack(
            fit: StackFit.expand,
            children: [
              _photoView(),
              Positioned(
                child: _backButton(),
                top: 10,
                left: 10,
              ),
              Positioned.fill(
                top: 13,
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
              Positioned(
                child: _shareButton(),
                top: 10,
                right: 10,
              ),
              Positioned(
                child: _heartButton(),
                bottom: 85,
                right: 20,
              ),
              Positioned(
                child: _saveButton(),
                bottom: 15,
                right: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

// The fullscreen photo display UI loaded from the url of the photo from the Unsplash API,
// navigated to via the id of a hero animation tag.

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

// Navigates back to HomeScreen from fullscreen.

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
        size: 26,
      ),
    );
  }

// Photographer name widget: calls the user (submitter) attribute from the Unsplash API.

  Widget _photographerName() {
    return Padding(
      padding: EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: AutoSizeText(
        'Photo by ' + widget.photo.user,
        maxLines: 1,
        minFontSize: 13,
        style: TextStyle(fontSize: 16),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

// Photo location widget: calls for the country and city attributes of the photo submission from the Unsplash API.
// If no location data is available, display nothing.

  Widget _photoLocation() {
    if (widget.photo.city != null && widget.photo.country != null) {
      return Text(
        (widget.photo.city + ', ' + widget.photo.country),
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    } else if (widget.photo.country != null) {
      return Text(
        (widget.photo.country),
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    } else if (widget.photo.city != null) {
      return Text(
        (widget.photo.country),
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      );
    }
    return Text('');
  }

// Share icon (no feature).

  Widget _shareButton() {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(
          msg: '''Can't share pictures right now''',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
      },
      child: Icon(
        CupertinoIcons.square_arrow_up,
        color: Colors.white,
        size: 26,
      ),
    );
  }

// Like-button and animation (no feature).

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
            width: 60,
            height: 60,
            child: LikeButton(
              padding: EdgeInsets.only(left: 4),
              onTap: onLikeButtonTapped,
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite_sharp,
                  color: isLiked ? Colors.redAccent : Colors.white,
                  size: 24,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    return !isLiked;
  }
}

// Download icon (no feature).

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
          Fluttertoast.showToast(
            msg: "Can't save pictures right now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            fontSize: 16.0,
          );
        },
        child: Container(
          color: Color.fromARGB(125, 255, 255, 255),
          width: 60,
          height: 60,
          child: Icon(
            CupertinoIcons.arrow_down,
            color: Colors.black,
            size: 24,
          ),
        ),
      ),
    ),
  );
}
