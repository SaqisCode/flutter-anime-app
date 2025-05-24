import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime_model.dart';
import '../widgets/anime_card_mylist.dart';
import '../widgets/bottom_navbar.dart';
import '../providers/my_list_provider.dart';
import '../pages/detail_page.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    final myListProvider = Provider.of<MyListProvider>(context);

    return Scaffold(
      body: myListProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : myListProvider.myAnimeList.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada List Anime',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              : RefreshIndicator(
  onRefresh: () async => await myListProvider.refreshAllData(),
  child: ListView.builder(
                    itemCount: myListProvider.myAnimeList.length,
                    itemBuilder: (context, index) {
                      final anime = myListProvider.myAnimeList[index];
                      return AnimeCard(
                        anime: anime,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(anime: anime),
                          ),
                        ),
                        showDeleteButton: true,
                      );
                    },
                  ),
                ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}