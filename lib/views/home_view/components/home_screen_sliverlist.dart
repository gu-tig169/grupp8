import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:grupp_8/services/store.dart';
import 'package:grupp_8/views/fullscreen_view/fullscreen_picture_index.dart';

import 'loader_indicators.dart';

// Handles and displays loading state. Calls sliver list builder to build the list of images from a request.

Widget imageListView() {
  if (PhotoStore().photoList.isEmpty && !PhotoStore().isLoading) {
    return noResultSliverLoaderIndicator();
  } else if (PhotoStore().photoList.isNotEmpty && !PhotoStore().isLoading) {
    return listViewBuilder();
  }
  return sliverLoaderIndicator();
}

// Builds a sliver list with network images fetched from the Unsplash API using photo store.

Widget listViewBuilder() {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade100, width: 1.5))),
              width: double.infinity,
              child: GestureDetector(
                child: Hero(
                  tag: PhotoStore().photoList[index].id,
                  child: Image.network(
                    PhotoStore().photoList[index].photoUrl,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
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
