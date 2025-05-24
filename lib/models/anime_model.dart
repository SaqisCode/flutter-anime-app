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
  final String trailerUrl;
  final String trailerImagesUrl;
  final String episodes;
  final String status;

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
    required this.trailerUrl,
    required this.trailerImagesUrl,
    required this.episodes,
    required this.status,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    if (json['entry'] != null) {
      final entry = json['entry'];
      return Anime(
        malId: entry['mal_id'] as int,
        title: (entry['title'] ?? 'No title') as String,
        imageUrl: (entry['images']?['jpg']?['large_image_url'] ?? '') as String,
        score: 0.0,
        synopsis: '',
        genres: [],
        season: 'Unknown',
        episodes: 'Unknown',
        status: 'Unknown',
        year: 0,
        producers: [],
        trailerUrl: 'tidak ada trailer',
        trailerImagesUrl: 'tidak ada trailer',
      );
    }
    
    return Anime(
      malId: json['mal_id'] as int,
      title: (json['title'] ?? json['title_english'] ?? 'No title') as String,
      imageUrl: (json['images']?['jpg']?['large_image_url'] ?? '') as String,
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      synopsis: (json['synopsis'] ?? 'No synopsis available') as String,
      genres: (json['genres'] as List?)?.map((g) => g['name'].toString()).toList() ?? [],
      season: (json['season']?.toString() ?? 'Unknown'),
      episodes: (json['episodes']?.toString() ?? 'Unknown'),
      status: (json['status']?.toString() ?? 'Unknown'),
      year: (json['year'] as int?) ?? 0,
      producers: (json['producers'] as List?)?.map((p) => p['name'].toString()).toList() ?? [],
      trailerUrl: (json['trailer']?['embed_url'] ?? 'tidak ada trailer') as String,
      trailerImagesUrl: (json['trailer']?['images']?['large_image_url'] ?? 'tidak ada trailer') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'title': title,
      'images': {
        'jpg': {
          'large_image_url': imageUrl,
        },
      },
      'score': score,
      'synopsis': synopsis,
      'genres': genres.map((g) => {'name': g}).toList(),
      'season': season,
      'year': year,
      'producers': producers.map((p) => {'name': p}).toList(),
      'trailer': {
        'embed_url': trailerUrl,
        'images': {
          'large_image_url': trailerImagesUrl,
        },
      },
      'episodes': episodes,
      'status': status,
    };
  }
}