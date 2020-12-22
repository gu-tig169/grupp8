import 'package:flutter/material.dart';
import 'package:grupp_8/models/photo.dart';
import 'package:grupp_8/services/photo_provider.dart';

// Methods for adding images to photo sliver list and paging methods.

final TextEditingController imageSearch = new TextEditingController();

class PhotoStore extends ChangeNotifier {
  static final PhotoStore _photoStore = PhotoStore._internal();
  factory PhotoStore() => _photoStore;

  bool isLoading = true;
  List<Photo> photoList = [];
  int pageCounter = 1;

  PhotoStore._internal();

  void incrementPageCounter() {
    pageCounter++;
    notifyListeners();
  }

  void resetPageCounter() {
    pageCounter = 1;
  }

  void clearPhotoList() {
    photoList.clear();
  }

  void callGetPhotos() {
    GetPhotos()
        .fetchPhotos(imageSearch.text, PhotoStore().pageCounter)
        .then((value) => {
              photoList.addAll(value),
              isLoading = false,
              notifyListeners(),
            });
  }
}
