import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime_model.dart';
import '../services/api_service.dart';
import '../providers/my_list_provider.dart';

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
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(0.3), // Warna dasar
            flexibleSpace: Stack(
              children: [
                // Layer 1: Background gradient untuk AppBar
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3, 0.6, 1.0],
                    ),
                  ),
                ),

                // Layer 2: Image dengan efek scroll normal
                FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Layer 1: Gambar utama
                      Image.network(
                        widget.anime.trailerImagesUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            ),
                      ),

                      // Layer 2: Gradasi atas
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 120, // Tinggi area gradasi
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.7),
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.3, 0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9), // Warna gelap
                    Colors.black.withOpacity(0.9), // Warna lebih terang
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
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
                      const Icon(
                        Icons.star_rate_rounded,
                        color: Color.fromARGB(255, 20, 180, 73),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.anime.score}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Text(
                        '  |  ',
                        style: TextStyle(color: Colors.grey[600], fontSize: 25),
                      ),
                      Text(
                        widget.anime.year.toString(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Text(
                        '  |  ',
                        style: TextStyle(color: Colors.grey[600], fontSize: 25),
                      ),
                      Text(
                        widget.anime.season,
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      Text(
                        '  |  ',
                        style: TextStyle(color: Colors.grey[600], fontSize: 25),
                      ),
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
                            .map(
                              (genre) => Chip(
                                label: Text(
                                  genre,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 20, 180, 73),
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor: Color.fromARGB(
                                  255,
                                  29,
                                  25,
                                  32,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 180, 73),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 0,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            )
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
                                isExpanded
                                    ? '... Baca Lebih Sedikit'
                                    : '... Baca Selengkapnya',
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.play_arrow_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.anime.episodes,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        ' episodes',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Producers: ${widget.anime.producers.join(', ')}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const SizedBox(height: 12),
                  // Tombol My List yang diperbaiki
    Consumer<MyListProvider>(
      builder: (context, myListProvider, child) {
        final isInList = myListProvider.isInMyList(widget.anime.malId);
        return GestureDetector(
          onTap: () async {
            final myListProvider = Provider.of<MyListProvider>(context, listen: false);
            final scaffold = ScaffoldMessenger.of(context);
            
            if (isInList) {
              await myListProvider.removeFromMyList(widget.anime.malId);
              scaffold.showSnackBar(
                SnackBar(
                  content: Text('Successfully removed from My List'),
                  duration: Duration(seconds: 1),
                ),
              );
            } else {
              await myListProvider.addToMyList(widget.anime);
              scaffold.showSnackBar(
                SnackBar(
                  content: Text('Successfully added to My List'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isInList ? Colors.grey[700] : Color.fromARGB(255, 20, 180, 73),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isInList ? Icons.playlist_add_check_rounded : Icons.playlist_add_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(
                  'My List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),                  const SizedBox(height: 8),
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
                        final limitedRecs =
                            snapshot.data!
                                .take(9)
                                .toList(); // Maksimal 9 item (3x3)
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
        childAspectRatio: 3 / 4, // Tetap pertahankan aspect ratio
        crossAxisSpacing: 4, // Jarak horizontal diperkecil
        mainAxisSpacing: 4, // Jarak vertikal diperkecil
      ),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final anime = recommendations[index];
        return GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => const Center(child: CircularProgressIndicator()),
            );

            try {
              final detailedAnime = await ApiService.getAnimeDetails(
                anime.malId,
              );
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(anime: detailedAnime),
                ),
              );
            } catch (e) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Failed to load details')));
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
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      color: Colors.grey[900],
                      child: const Icon(
                        Icons.broken_image,
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
