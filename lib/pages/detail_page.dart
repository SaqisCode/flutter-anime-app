import 'package:flutter/material.dart';
import '../models/anime_model.dart';

class DetailPage extends StatelessWidget {
  final Anime anime;

  const DetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('${anime.score}', style: const TextStyle(color: Colors.white)), 
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.amber, size: 17),             ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children:
                        anime.genres
                            .map((genre) => Chip(label: Text(genre)))
                            .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Synopsis',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime.synopsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'Season: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        anime.season,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Year: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        anime.year.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
