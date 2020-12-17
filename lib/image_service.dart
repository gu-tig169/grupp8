import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = 'jAqnxNTNnSEKikg3SA6VMuWrVgxCjKKI8PS7S7D8FeY';

Future<Photo> fetchRandomFeaturedPhoto() async {
  var response = await http.get(
    'https://api.unsplash.com/photos/random?featured',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
    },
  );
  final responseJson = jsonDecode(response.body);

  return Photo.fromJson(responseJson);
}

Future<List<Photo>> getImages() async {
  var response = await http.get(
    'https://api.unsplash.com/photos/random?count=20',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
    },
  );
  List jsonData = json.decode(response.body);
  return jsonData.map((photos) => new Photo.fromJson(photos)).toList();
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
