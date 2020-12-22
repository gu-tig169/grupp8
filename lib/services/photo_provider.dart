import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/photo.dart';

String apiKey = 'QM7rfeVBnVQKCSdSD2iL5yC8qt80lWstn6glQXqoFR0';

// This class provides photos from the Unsplash API based on the photo object
// Get request for a random Featured Photo from Unsplash API 

Future<Photo> fetchRandomFeaturedPhoto() async {
  final response = await http.get(
    'https://api.unsplash.com/photos/random?featured',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    return Photo.fromJson(res);
  } else {
    throw Exception('Failed to load image');
  }
}

// Get request for photos through image search. If no search query, fetch (5) random photos.

class GetPhotos {
  Future<List<Photo>> fetchPhotos(String imageSearch, int pageCounter) async {
    final url = imageSearch.isNotEmpty
        ? 'https://api.unsplash.com/search/photos?query=$imageSearch&page=$pageCounter'
        : 'https://api.unsplash.com/photos/random?count=5';
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
      },
    );

    if (response.statusCode == 200) {
      final res = jsonDecode(utf8.decode(response.bodyBytes));
      List data = imageSearch.isNotEmpty ? res['results'] : res;
      return data.map((photo) => new Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
