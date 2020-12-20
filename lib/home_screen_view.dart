import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grupp_8/image_service.dart';
import 'home_screen_app_bar.dart';
import 'image_service.dart';
import 'loader_indicators.dart';
import 'photo.dart';
import 'store.dart';
import 'package:flutter/cupertino.dart';
import 'fullscreen_picture_view.dart';

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
                  delegate: HomeScreenAppBar(
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
                    tag: PhotoStore().photoList[index].id,
                    child:
                        Image.network(PhotoStore().photoList[index].photoUrl),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return FullScreen(PhotoStore().photoList[index]);
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
