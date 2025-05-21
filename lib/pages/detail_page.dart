import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../services/api_service.dart';

class DetailPage extends StatefulWidget {
  final Anime anime;

  const DetailPage({super.key, required this.anime});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isExpanded = false;
  late Future<List<Anime>> recommendedAnime;

  @override
  void initState() {
    super.initState();
    recommendedAnime = ApiService.getRecommendedAnime(widget.anime.malId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            elevation: 0, // Hilangkan shadow
            backgroundColor: Colors.transparent, // Background transparan
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.anime.trailerImagesUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
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
                    widget.anime.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color.fromARGB(255, 20, 180, 73), size: 20),
                      const SizedBox(width: 4),
                      Text('${widget.anime.score}', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      Text('  |  ', style: TextStyle(color: Colors.grey[600], fontSize: 25)),                      
                      Text(
                        widget.anime.year.toString(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Text('  |  ', style: TextStyle(color: Colors.grey[600], fontSize: 25)),    
                      Text(
                        widget.anime.season,
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      Text('  |  ', style: TextStyle(color: Colors.grey[600], fontSize: 25)),    
                      Text(
                        widget.anime.status,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),                  
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                      widget.anime.genres
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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final textSpan = TextSpan(
                        text: widget.anime.synopsis,
                        style: TextStyle(color: Colors.grey[600]),
                      );
                      
                      final textPainter = TextPainter(
                        text: textSpan,
                        maxLines: 3,
                        textDirection: TextDirection.ltr,
                      )..layout(maxWidth: constraints.maxWidth);
                      
                      if (textPainter.didExceedMaxLines) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.anime.synopsis,
                              style: TextStyle(color: Colors.grey[600]),
                              maxLines: isExpanded ? null : 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? '... Baca Lebih Sedikit' : '... Baca Selengkapnya',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 20, 180, 73),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text(
                          widget.anime.synopsis,
                          style: TextStyle(color: Colors.grey[600]),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        widget.anime.episodes,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(' episodes', style: TextStyle(color: Colors.white, fontSize: 15)),  
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Producers: ${widget.anime.producers.join(', ')}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    thickness: 1.0, // Ketebalan garis
                    indent: 0, // Jarak dari sisi kiri
                    endIndent: 0, // Jarak dari sisi kanan
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),
                  FutureBuilder<List<Anime>>(
                    future: recommendedAnime,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No recommendations available');
                      } else {
                        final limitedRecs = snapshot.data!.take(9).toList(); // Maksimal 9 item (3x3)
                        return _buildRecommendationList(limitedRecs);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
  Widget _buildRecommendationList(List<Anime> recommendations) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 4), // Padding atas diperkecil
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 kolom
        childAspectRatio: 9 / 16, // Tetap pertahankan aspect ratio
        crossAxisSpacing: 8, // Jarak horizontal diperkecil
        mainAxisSpacing: 8, // Jarak vertikal diperkecil
      ),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final anime = recommendations[index];
        return GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
            
            try {
              final detailedAnime = await ApiService.getAnimeDetails(anime.malId);
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(anime: detailedAnime),
                ),
              );
            } catch (e) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to load details')),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.all(1), // Margin sangat kecil
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.broken_image, 
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}