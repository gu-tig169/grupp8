import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'photo.dart';

String apiKey = 'Y_eztk9R60rYLH2HaYE3SD4B3jShJWKpxZY0D00tA1E';

Future<Photo> fetchRandomFeaturedPhoto() async {
  final response = await http.get(
    'https://api.unsplash.com/photos/random?featured',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
    },
  );

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    return Photo.fromJson(res);
  } else {
    throw Exception('Failed to load image');
  }
}

class GetPhotos {
  Future<List<Photo>> fetchPhotos(String imageSearch, int pageCounter) async {
    final url = imageSearch.isNotEmpty
        ? 'https://api.unsplash.com/search/photos?query=$imageSearch&page=$pageCounter'
        : 'https://api.unsplash.com/photos/random?count=5';
    print(url);
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
      },
    );

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      List data = imageSearch.isNotEmpty ? res['results'] : res;
      return data.map((photo) => new Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}

// class GetPhotos {
//   Future<List<Photo>> fetchPhotos() async {
//     final response = await http.get(
//       'https://api.unsplash.com/photos/random?count=5',
//       headers: {
//         HttpHeaders.authorizationHeader: "Client-ID " + apiKey,
//       },
//     );
//     if (response.statusCode == 200) {
//       final res = jsonDecode(response.body);
//       List data = res;
//       return data.map((photo) => new Photo.fromJson(photo)).toList();
//     } else {
//       throw Exception('Failed to load list of images');
//     }
//   }
// }
