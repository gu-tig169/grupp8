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
