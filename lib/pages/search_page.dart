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
  bool hasSearched = false; // Tambahkan variabel untuk menandai sudah melakukan pencarian

  void searchAnime(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        hasSearched = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      hasSearched = true; // Setelah melakukan pencarian
    });
    
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
          SizedBox(height: 8,),
          SearchBarWidget(
            onSearch: searchAnime,
          ),
isLoading
    ? Expanded( // Gunakan Expanded untuk mengisi seluruh ruang vertikal
        child: Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 20, 180, 73),
          ),
        ),
      )
    : Expanded(
        child: hasSearched && searchResults.isEmpty
            ? Center(
                child: Text(
                  'Cari anime favorite anda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
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