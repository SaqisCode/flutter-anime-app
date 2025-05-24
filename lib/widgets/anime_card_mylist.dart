import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/anime_model.dart';
import '../providers/my_list_provider.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback onTap;
  final bool showDeleteButton;

  const AnimeCard({
    super.key,
    required this.anime,
    required this.onTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Color.fromARGB(255, 29, 25, 32),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Anime Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    anime.imageUrl,
                    height: 150,
                    width: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 150,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.error, size: 30),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Anime Details
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          anime.genres.join(', '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Rating dan Year
                        Row(
                          children: [
                            const Icon(Icons.star_rate_rounded, 
                              color: Color.fromARGB(255, 20, 180, 73), 
                              size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${anime.score}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.calendar_today, 
                              size: 13, 
                              color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              anime.year.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Status dan Tombol Ubah Status
Consumer<MyListProvider>(
  builder: (context, provider, child) {
    final currentStatus = provider.getWatchStatus(anime.malId);
    return SizedBox(
      height: 24,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 29, 25, 32),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 20, 180, 73),
            width: 0.5,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentStatus,
            isDense: true,
            dropdownColor: const Color.fromARGB(255, 29, 25, 32),
            borderRadius: BorderRadius.circular(12), // Match container border
            icon: const Icon(Icons.arrow_drop_down, 
              size: 16,
              color: Colors.white
            ),
            iconSize: 16,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            items: [
              DropdownMenuItem(
                value: 'Not watched yet',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, // Clock icon for "will watch"
                      size: 10,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Not watched yet',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'Already watched',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, // Checkmark icon for "watched"
                      size: 10,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Already watched',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onChanged: (String? newValue) {
              if (newValue != null && newValue != currentStatus) {
                provider.toggleWatchStatus(anime.malId);
              }
            },
          ),
        ),
      ),
    );
  },
),
                        const Spacer(),
                        Row(
                          children: [
                            // View Details Button
                            Container(
                              width: 140,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 20, 180, 73),
                                    Color.fromARGB(255, 46, 213, 100),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 20, 180, 73).withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: onTap,
                                  borderRadius: BorderRadius.circular(8),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View Details',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Delete Button (only shown when showDeleteButton is true)
                            if (showDeleteButton)
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 80, 80),
                                      Color.fromARGB(255, 255, 40, 40),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _showDeleteConfirmationDialog(context),
                                    borderRadius: BorderRadius.circular(8),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 29, 25, 32),
        title: const Text(
          'Delete Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${anime.title}" from My List?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 20, 180, 73)),
            ),
          ),
          TextButton(
            onPressed: () {
              final myListProvider = Provider.of<MyListProvider>(context, listen: false);
              myListProvider.removeFromMyList(anime.malId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${anime.title}" Successfully removed from My List'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}