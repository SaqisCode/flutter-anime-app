import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.jikan.moe/v4';

  static Future<List<Anime>> getPopularAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/top/anime?filter=bypopularity'));
    return _parseAnimeResponse(response);
  }

  static Future<List<Anime>> getFavoriteAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/top/anime?filter=favorite'));
    return _parseAnimeResponse(response);
  }

  static Future<Anime> getAnimeDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/anime/$id'));
    if (response.statusCode == 200) {
      return Anime.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load anime details');
    }
  }

  static Future<List<Anime>> searchAnime(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/anime?q=$query'));
    return _parseAnimeResponse(response);
  }

  static List<Anime> _parseAnimeResponse(http.Response response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((json) => Anime.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load anime');
    }
  }
}