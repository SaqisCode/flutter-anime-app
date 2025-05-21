import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../services/api_service.dart';
import '../widgets/anime_slider.dart';

class DetailPage extends StatelessWidget {
  final Anime anime;

  const DetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                anime.trailerImagesUrl,
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
                      const Icon(Icons.star, color: Color.fromARGB(255, 20, 180, 73), size: 20),
                      const SizedBox(width: 4),
                      Text('${anime.score}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                      Text('  |  ', style: TextStyle(color: Colors.grey[600], fontSize: 25)),                      Text(
                        anime.year.toString(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      Text('  |  ', style: TextStyle(color: Colors.grey[600], fontSize: 25)),    
                      Text(
                        anime.season,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13.5),
                      ),
                      Text('  |  ', style: TextStyle(color: Colors.grey[600], fontSize: 25)),    
                      Text(
                        anime.status,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),                  
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                      anime.genres
                        .map((genre) => Chip(
                          label: Text(
                            genre,
                            style: const TextStyle(color: Color.fromARGB(255, 20, 180, 73), fontSize: 12),
                          ),
                          backgroundColor: Color.fromARGB(255, 29, 25, 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Color.fromARGB(255, 20, 180, 73)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ))
                        .toList(),
                  ),                  
                  const SizedBox(height: 16),
                  Text(
                    anime.synopsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        anime.episodes,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(' episodes', style: TextStyle(color: Colors.white, fontSize: 15)),  
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Producers: ${anime.producers.join(', ')}',
                    style: TextStyle(color: Colors.grey[400]),
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