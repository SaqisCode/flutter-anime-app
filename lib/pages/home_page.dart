import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/anime_slider.dart';
import '../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ANIDEA',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 20, 180, 73),
          ),
        ),
        centerTitle: false,
        flexibleSpace: Container(
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
        backgroundColor: Color.fromARGB(255, 29, 25, 32),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Popular Anime Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Anime',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigation to popular anime page
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color.fromARGB(255, 20, 180, 73),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  AnimeSlider(
                    title: '',
                    future: ApiService.getPopularAnime(),
                  ),
                ],
              ),
            ),

            // Favorite Anime Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Favorite Anime',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigation to favorite anime page
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color.fromARGB(255, 20, 180, 73),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  AnimeSlider(
                    title: '',
                    future: ApiService.getFavoriteAnime(),
                  ),
                ],
              ),
            ),

            // Upcoming Anime Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Anime',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigation to upcoming anime page
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color.fromARGB(255, 20, 180, 73),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  AnimeSlider(
                    title: '',
                    future: ApiService.getUpComingAnime(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}