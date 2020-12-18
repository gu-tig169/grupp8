import 'package:flutter/material.dart';
import 'package:grupp_8/image_service.dart';
import 'aboutUs_screen.dart';
import 'image_service.dart';

final TextEditingController imageSearch = new TextEditingController();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  List<Photo> photoList = [];

  @override
  void initState() {
    super.initState();
    GetPhotos().fetchPhotos().then((value) => setState(() {
          photoList.addAll(value);
        }));
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
                delegate: MySliverAppBar(expandedHeight: 350),
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
    return _listViewBuilder();
    // if (photoList.isNotEmpty) {
    //   return _listViewBuilder();
    // }
    // return loadingIndicator();
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

  //   [
  //   Column(
  //     children: <Widget>[
  //       Container(
  //         width: double.infinity,
  //         child: ListView.builder(
  //           controller: _scrollController,
  //           itemCount: photoList.length,
  //           itemBuilder: (context, index) {
  //             return Card(
  //                 child: Image.network(photoList[index].photoUrl));
  //           },
  //         ),
  //       ),
  //     ],
  //   ),
  // ],

  // Widget loadingIndicator() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Center(
  //         child: Container(
  //           height: 20,
  //           width: 20,
  //           margin: EdgeInsets.all(5),
  //           child: CircularProgressIndicator(
  //             strokeWidth: 2.0,
  //             valueColor: AlwaysStoppedAnimation(Colors.white),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

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
              child: _testPhoto(),
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

  Widget _testPhoto() {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _futureFeaturedPhotoBuilder() {
    return FutureBuilder<Photo>(
        future: fetchRandomFeaturedPhoto(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _topImage(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return loadingIndicator();
        });
  }

  Widget loadingIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(5),
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      ],
    );
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
                (photo.user.toUpperCase()),
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
          // shadows: <Shadow>[
          //   Shadow(
          //     offset: Offset(1.0, 1.0),
          //     blurRadius: 3.0,
          //     color: Color.fromARGB(255, 0, 0, 0),
          //   )
          // ],
          color: Color.fromARGB(255, 225, 255, 255),
          fontSize: 22,
          fontFamily: "Syncopate"),
    );
  }
}
