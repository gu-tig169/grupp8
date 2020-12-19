import 'package:flutter/material.dart';
import 'photo.dart';
import 'image_service.dart';

final TextEditingController imageSearch = new TextEditingController();

class PhotoStore extends ChangeNotifier {
  static final PhotoStore _photoStore = PhotoStore._internal();
  factory PhotoStore() => _photoStore;

  bool isLoading = true;
  List<Photo> photoList = [];
  int pageCounter = 1;

  PhotoStore._internal() {}

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
    isLoading = true;
    GetPhotos()
        .fetchPhotos(imageSearch.text, PhotoStore().pageCounter)
        .then((value) => {
              photoList.addAll(value),
              isLoading = false,
              notifyListeners(),
            });
  }
}
