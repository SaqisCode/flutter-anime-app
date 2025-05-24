import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/anime_model.dart';

class AnimeStatusProvider extends ChangeNotifier {
  Map<int, String> _statusMap = {}; // Key: animeId, Value: status

  String getStatus(int animeId) => _statusMap[animeId] ?? 'Akan ditonton';

  void toggleStatus(int animeId) {
    _statusMap[animeId] = getStatus(animeId) == 'Akan ditonton' 
      ? 'Sudah ditonton' 
      : 'Akan ditonton';
    notifyListeners();
  }
}