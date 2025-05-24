import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/anime_model.dart';

class MyListProvider extends ChangeNotifier {
  List<Anime> _myAnimeList = [];
  Map<int, String> _watchStatus = {};
  bool _isLoading = false;

  List<Anime> get myAnimeList => _myAnimeList;
  bool get isLoading => _isLoading;

  MyListProvider() {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _loadMyList();
      await _loadWatchStatus();
    } catch (e) {
      debugPrint('Initialization error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshAllData() async {
    try {
      await _loadMyList();
      await _loadWatchStatus();
    } catch (e) {
      debugPrint('Error refreshing data: $e');
      rethrow;
    }
  }

  Future<void> _loadMyList() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('myAnimeList');
      
      if (jsonString != null) {
        final jsonList = json.decode(jsonString) as List;
        _myAnimeList = jsonList.map((json) => Anime.fromJson(json)).toList();
      }
    } catch (e) {
      debugPrint('Error loading my list: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveMyList() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _myAnimeList.map((anime) => anime.toJson()).toList();
      await prefs.setString('myAnimeList', json.encode(jsonList));
    } catch (e) {
      debugPrint('Error saving my list: $e');
    }
  }

  Future<void> addToMyList(Anime anime) async {
    if (!_myAnimeList.any((a) => a.malId == anime.malId)) {
      _myAnimeList.add(anime);
      await _saveMyList();
      notifyListeners();
    }
  }

  Future<void> removeFromMyList(int malId) async {
    _myAnimeList.removeWhere((anime) => anime.malId == malId);
    await _saveMyList();
    notifyListeners();
  }

  bool isInMyList(int malId) {
    return _myAnimeList.any((anime) => anime.malId == malId);
  }

  // Watch status methods
  String getWatchStatus(int malId) => _watchStatus[malId] ?? 'Not watched yet';

  Future<void> toggleWatchStatus(int malId) async {
    _watchStatus[malId] = getWatchStatus(malId) == 'Not watched yet' 
      ? 'Already watched' 
      : 'Not watched yet';
    await _saveWatchStatus();
    notifyListeners();
  }

  Future<void> _loadWatchStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('watchStatus');
      if (jsonString != null) {
        _watchStatus = Map<int, String>.from(
          json.decode(jsonString).map((k, v) => MapEntry(int.parse(k), v)));
      }
    } catch (e) {
      debugPrint('Error loading watch status: $e');
    }
  }

  Future<void> _saveWatchStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('watchStatus', 
        json.encode(_watchStatus.map((k, v) => MapEntry(k.toString(), v))));
    } catch (e) {
      debugPrint('Error saving watch status: $e');
    }
  }
}