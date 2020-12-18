import 'package:flutter/material.dart';
import 'package:grupp_8/image_service.dart';
import 'about_us_screen.dart';
import 'image_service.dart';
import 'loader_indicators.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  List<Photo> photoList = [];
  Future<Photo> featuredPhoto;

  @override
  void initState() {
    super.initState();
    GetPhotos().fetchPhotos().then((value) => setState(() {
          photoList.addAll(value);
        }));
    featuredPhoto = fetchRandomFeaturedPhoto();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      var triggerFetchMoreSize =
          0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        print('Loading more pics...');
        GetPhotos().fetchPhotos().then((value) {
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
                    expandedHeight: 350, featuredPhoto: featuredPhoto),
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
                  width: double.infinity,
                  child: Card(
                    child: Image.network(photoList[index].photoUrl),
                  ))
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
  final TextEditingController imageSearch = new TextEditingController();

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
            color: Color.fromARGB(255, 86, 75, 83),
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
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: _searchImageTextField(),
            ),
          ],
        ),
        Positioned(
          top: 50 - shrinkOffset,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              child: _futureFeaturedPhotoBuilder(featuredPhoto),
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
      height: 210,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(photo.photoUrl), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.4),
            Colors.black.withOpacity(.2),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                ('By: ' + photo.user),
                style: TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchImageTextField() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: TextField(
        style: TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.bottom,
        controller: imageSearch,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30, width: 2)),
            hintText: "Search..",
            hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
      ),
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
