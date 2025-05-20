import 'package:flutter/material.dart';
import 'package:flutter_anime_tes/pages/detail_page.dart';
import '../models/anime_model.dart';
import '../services/api_service.dart';
import '../widgets/anime_card_search.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Anime> searchResults = [];
  bool isLoading = false;

  void searchAnime(String query) async {
    setState(() => isLoading = true);
    try {
      final results = await ApiService.searchAnime(query);
      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(onSearch: searchAnime),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final anime = searchResults[index];
                      return AnimeCard(
                        anime: anime,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(anime: anime),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}