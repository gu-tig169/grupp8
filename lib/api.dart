import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = 'sZlS6tByzXQZ0G8GsXJqoaqRO5ZlV0iymgKK64_tKN8';
List listOfPhotos = [];

Future<Photo> fetchRandomFeaturedPhoto() async {
  var response = await http.get(
    'https://api.unsplash.com/photos/random?featured',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID" + apiKey,
    },
  );
  final responseJson = jsonDecode(response.body);

  return Photo.fromJson(responseJson);
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
