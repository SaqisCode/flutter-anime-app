class Genre {
  final int malId;
  final String name;

  Genre({required this.malId, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      malId: json['mal_id'],
      name: json['name'],
    );
  }
}