import 'package:flutter/material.dart';

Widget loadingIndicator() {
  return Container(
    height: 200,
    child: Column(
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
    ),
  );
}

Widget sliverLoaderIndicator() {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Card(
                  child: loadingIndicator(),
                ))
          ],
        );
      },
      childCount: 1,
    ),
  );
}

Widget noResultIndicator() {
  return Container(
    height: 200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.all(5),
            child: Text('No search results found'),
          ),
        ),
      ],
    ),
  );
}

Widget noResultSliverLoaderIndicator() {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Card(
                  child: noResultIndicator(),
                ))
          ],
        );
      },
      childCount: 1,
    ),
  );
}
