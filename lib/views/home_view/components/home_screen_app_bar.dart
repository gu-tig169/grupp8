import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:grupp_8/models/photo.dart';

import 'loader_indicators.dart';
import 'store.dart';

import '../../about_view/about_us_screen_view.dart';

// Custom made app bar for text input search field & featured image to facilitate scroll fade using slivers.
// Inherits from sliver delegate to build below design according to Sliver constraints.

class HomeScreenAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Future<Photo> featuredPhoto;

  HomeScreenAppBar(
      {@required this.expandedHeight, @required this.featuredPhoto});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          child: Container(
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        Positioned.fill(
          top: -shrinkOffset,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: _futureFeaturedPhotoBuilder(featuredPhoto),
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: (0 + shrinkOffset / expandedHeight),
            child: Container(
              width: double.infinity,
              height: kToolbarHeight,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade100, width: 1.5))),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Align(
              alignment: Alignment.center,
              child: _searchImageTextField(),
            ),
          ),
        ),
        Positioned.fill(
          top: -shrinkOffset,
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (AboutUs())),
                );
              },
            ),
          ),
        ),
        Positioned.fill(
          top: -shrinkOffset,
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Align(alignment: Alignment.topCenter, child: _logoText()),
          ),
        ),
        Positioned.fill(
          top: -shrinkOffset,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

// Fetches a random featured photo.

  Widget _futureFeaturedPhotoBuilder(Future<Photo> featuredPhoto) {
    return FutureBuilder<Photo>(
        future: featuredPhoto,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _topImage(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return loadingIndicator();
        });
  }

// Design for the featured header/top image.

  Widget _topImage(Photo photo) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            image: NetworkImage(photo.photoUrl),
            fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              stops: [
                0.05,
                0.1,
                0.3
              ],
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                ('Photo by ' + photo.user),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Design for search field.

  Widget _searchImageTextField() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10.0,
                    sigmaY: 10.0,
                  ),
                  child: CupertinoTextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      PhotoStore().resetPageCounter();
                      PhotoStore().clearPhotoList();
                      PhotoStore().callGetPhotos();
                    },
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: imageSearch,
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ),
                    ),
                    placeholder: "Search photos",
                    placeholderStyle: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 118, 118, 128),
                    ),
                  ),
                ),
              ),
            )));
  }

// Logo widget.

  Widget _logoText() {
    return Text(
      'PLENTY OF PICS',
      style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.normal,
          fontFamily: "Syncopate"),
    );
  }
}
