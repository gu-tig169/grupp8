import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = 'Y_eztk9R60rYLH2HaYE3SD4B3jShJWKpxZY0D00tA1E';

Future<Photo> fetchRandomFeaturedPhoto() async {
  var response = await http.get(
    'https://api.unsplash.com/photos/random?featured',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
    },
  );

  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    return Photo.fromJson(responseJson);
  } else {
    throw Exception('Failed to load image');
  }
}

class GetPhotos {
  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(
      'https://api.unsplash.com/photos/random?count=5',
      headers: {
        HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List data = json;
      return data.map((photo) => new Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load list of images');
    }
  }
}

class Photo {
  String id;
  String altDescription;
  String photoUrl;
  String user;

  Photo({this.id, this.altDescription, this.photoUrl, this.user});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      altDescription: json['alt_description'],
      photoUrl: json['urls']['small'],
      user: json['user']['name'],
    );
  }
}
