import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grupp_8/models/photo.dart';
import 'package:grupp_8/services/photo_provider.dart';
import 'package:flutter/cupertino.dart';

import 'components/home_screen_app_bar.dart';
import '../../services/store.dart';
import 'components/loader_indicators.dart';

import '../fullscreen_view/fullscreen_picture_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  Future<Photo> featuredPhoto;
  final TextEditingController imageSearch = new TextEditingController();

// Fills featured image and photo list with images from Unsplash API on startup.

  @override
  void initState() {
    super.initState();
    PhotoStore().addListener(() {
      setState(() {});
    });
    PhotoStore().callGetPhotos();
    featuredPhoto = fetchRandomFeaturedPhoto();
  }
//Gets new photo requests when reaching end of scroll view to return more images (endless scroll/paging).

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

// Design for the home screen view. 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
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

// Handles and displays loading state. Calls sliver list builder to build the list of images from a request.

  Widget _imageListView() {
    if (PhotoStore().photoList.isEmpty && !PhotoStore().isLoading) {
      return noResultSliverLoaderIndicator();
    } else if (PhotoStore().photoList.isNotEmpty && !PhotoStore().isLoading) {
      return _listViewBuilder();
    }
    return sliverLoaderIndicator();
  }

// Builds a sliver list with network images fetched from the Unsplash API using photo store.

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
                    child: Image.network(PhotoStore().photoList[index].photoUrl,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress)
                      {
                        if (loadingProgress == null)
                          return child;
                        return Container(
                          width: double.infinity,
                          height: 500,
                          child: loadingIndicator(),
                        );
                      },
                    ),
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
