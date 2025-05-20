import 'package:flutter/material.dart';
import 'package:flutter_anime_tes/pages/detail_page.dart';
import '../models/anime_model.dart';
import 'anime_card.dart';

class AnimeSlider extends StatelessWidget {
  final String title;
  final Future<List<Anime>> future;

  const AnimeSlider({
    super.key,
    required this.title,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Anime>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              final animeList = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  final anime = animeList[index];
                  return SizedBox(
                    width: 150,
                    child: AnimeCard(
                      anime: anime,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(anime: anime),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}