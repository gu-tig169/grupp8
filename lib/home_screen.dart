import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grupp_8/image_service.dart';
import 'about_us_screen.dart';
import 'image_service.dart';
import 'loader_indicators.dart';
import 'photo.dart';
import 'store.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  Future<Photo> featuredPhoto;
  final TextEditingController imageSearch = new TextEditingController();

  @override
  void initState() {
    super.initState();
    PhotoStore().addListener(() {
      setState(() {});
    });
    PhotoStore().callGetPhotos();
    featuredPhoto = fetchRandomFeaturedPhoto();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('end reached');
        PhotoStore().incrementPageCounter();
        PhotoStore().callGetPhotos();
      }
    }
    return true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Material(
          child: NotificationListener(
            onNotification: onNotification,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(
                      expandedHeight: 300, featuredPhoto: featuredPhoto),
                  pinned: true,
                ),
                _imageListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageListView() {
    if (PhotoStore().photoList.isEmpty && !PhotoStore().isLoading) {
      return noResultSliverLoaderIndicator();
    } else if (PhotoStore().photoList.isNotEmpty && !PhotoStore().isLoading) {
      return _listViewBuilder();
    }
    return sliverLoaderIndicator();
  }

  Widget _listViewBuilder() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade100, width: 1.5))),
                width: double.infinity,
                child: GestureDetector(
                  child: Hero(
                    tag: 'heroTag$index',
                    child:
                        Image.network(PhotoStore().photoList[index].photoUrl),
                  ),
                  onTap: () {
                    print('heroTag$index');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return FullScreen('heroTag$index');
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
        childCount: PhotoStore().photoList.length,
      ),
    );
  }
}

// Vill alltså skicka med "heroTag$index" och sätta in det i heroTag som finns nedan
// i FullScreen samt visa bild från listan istället för den statiska. Använder även en
// chachefunktion som gör så att den inte behöver ladda in hela bilden en gång till.

class FullScreen extends StatefulWidget {
  final String heroTag;

  FullScreen(this.heroTag);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: widget.heroTag,
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1608411404720-c8f0417bcdba?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
              placeholder: null,
              errorWidget: null,
            ),
          ),
        ),
        onTap: () {
          print(widget.heroTag);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Future<Photo> featuredPhoto;

  MySliverAppBar({@required this.expandedHeight, @required this.featuredPhoto});

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
            //color: Color.fromARGB(255, 49, 41, 47),
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
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                    placeholder: "Search photos",
                    placeholderStyle: TextStyle(color: Colors.white),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 118, 118, 128),
                    ),
                  ),
                ),
              ),
            )));
  }

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
