import 'package:flutter/material.dart';
import 'package:flutter_anime_tes/pages/detail_page.dart';
import '../models/anime_model.dart';
import '../widgets/anime_card.dart';
import '../widgets/bottom_navbar.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<Anime> myAnimeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myAnimeList.isEmpty
          ? const Center(
              child: Text(
                'my list page',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: myAnimeList.length,
              itemBuilder: (context, index) {
                final anime = myAnimeList[index];
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}