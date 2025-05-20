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
        title: const Text('ANIDEA', 
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 20, 180, 73),
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                      // Add navigation or action here
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
              AnimeSlider(
                title: '',
                future: ApiService.getPopularAnime(),
              ),
              const SizedBox(height: 20),
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
                      // Add navigation or action here
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
              AnimeSlider(
                title: '',
                future: ApiService.getFavoriteAnime(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}