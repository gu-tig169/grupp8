import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grupp_8/image_service.dart';
import 'about_us_screen.dart';
import 'image_service.dart';
import 'loader_indicators.dart';
import 'photo.dart';

final TextEditingController imageSearch = new TextEditingController();
List<Photo> photoList = [];
int pageCounter = 1;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  Future<Photo> featuredPhoto;

  @override
  void initState() {
    super.initState();
    GetPhotos()
        .fetchPhotos(imageSearch.text, pageCounter)
        .then((value) => setState(() {
              photoList.addAll(value);
            }));
    featuredPhoto = fetchRandomFeaturedPhoto();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // var triggerFetchMoreSize =
        //     0.8 * _scrollController.position.maxScrollExtent;
        // if (_scrollController.position.pixels > triggerFetchMoreSize) {
        print('Loading more pics...');
        pageCounter = pageCounter + 1;
        GetPhotos().fetchPhotos(imageSearch.text, pageCounter).then((value) {
          setState(() {
            photoList.addAll(value);
          });
        });
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
    return SafeArea(
      child: Material(
        child: NotificationListener(
          onNotification: onNotification,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(
                    expandedHeight: 345, featuredPhoto: featuredPhoto),
                pinned: true,
              ),
              _imageListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageListView() {
    if (photoList.isNotEmpty) {
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
                  child: Image.network(photoList[index].photoUrl))
            ],
          );
        },
        childCount: photoList.length,
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
            color: Color.fromARGB(255, 49, 41, 47),
          ),
        ),
        Positioned(
          top: -shrinkOffset,
          child: IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (AboutUs())),
                );
              }),
        ),
        Positioned(
          top: 14 - shrinkOffset,
          right: 90,
          child: _logoText(),
        ),
        Positioned(
          top: -shrinkOffset,
          right: 0,
          child: IconButton(
              icon: Icon(Icons.person, color: Colors.white), onPressed: () {}),
        ),
        Positioned(
          top: 50 - shrinkOffset,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: _futureFeaturedPhotoBuilder(featuredPhoto),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  child: _searchImageTextField(),
                ),
              ),
            ],
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
      height: 239,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(photo.photoUrl), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              stops: [
                0.1,
                0.16,
                0.3
              ],
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                ('Photo by ' + photo.user),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchImageTextField() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 40,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              photoList.clear();
              GetPhotos()
                  .fetchPhotos(imageSearch.text, pageCounter)
                  .then((value) {
                photoList.addAll(value);
              });
              pageCounter = 1;
              print("search");
            },
            style: TextStyle(color: Colors.white70),
            cursorColor: Color.fromARGB(255, 107, 90, 100),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            controller: imageSearch,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              prefixIcon: Icon(Icons.search, color: Colors.white70),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )),
              fillColor: Color.fromARGB(60, 118, 118, 128),
              filled: true,
              hintText: "Search photo...",
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _logoText() {
    return Text(
      'PLENTY OF PICS',
      style: TextStyle(
          color: Color.fromARGB(255, 225, 255, 255),
          fontSize: 22,
          fontFamily: "Syncopate"),
    );
  }
}
