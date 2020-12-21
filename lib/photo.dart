class Photo {
  String id;
  String altDescription;
  String photoUrl;
  String user;
  String location;

  Photo(
      {this.id, this.altDescription, this.photoUrl, this.user, this.location});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      altDescription: json['alt_description'],
      photoUrl: json['urls']['small'],
      user: json['user']['name'],
      location: json['user']['location'],
    );
  }
}
