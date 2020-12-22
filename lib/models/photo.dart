class Photo {
  String id;
  String altDescription;
  String photoUrl;
  String user;
  String country;
  String city;

  Photo({
    this.id,
    this.altDescription,
    this.photoUrl,
    this.user,
    this.country,
    this.city,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    var locationCountry =
        json['location'] != null ? json['location']['country'] : null;
    var locationCity =
        json['location'] != null ? json['location']['city'] : null;

    return Photo(
      id: json['id'],
      altDescription: json['alt_description'],
      photoUrl: json['urls']['regular'],
      user: json['user']['name'],
      country: locationCountry,
      city: locationCity,
    );
  }
}
