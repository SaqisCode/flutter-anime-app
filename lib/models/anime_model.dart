class Anime {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;
  final String synopsis;
  final List<String> genres;
  final String season;
  final int year;
  final List<String> producers;

  Anime({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.synopsis,
    required this.genres,
    required this.season,
    required this.year,
    required this.producers,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'],
      title: json['title'] ?? json['title_english'] ?? 'No title',
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      score: json['score']?.toDouble() ?? 0.0,
      synopsis: json['synopsis'] ?? 'No synopsis available',
      genres: (json['genres'] as List?)?.map((g) => g['name'].toString()).toList() ?? [],
      season: json['season']?.toString() ?? 'Unknown',
      year: json['year'] ?? 0,
      
      producers: (json['producers'] as List?)?.map((p) => p['name'].toString()).toList() ?? [],
    );
  }
}