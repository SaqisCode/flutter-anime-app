import 'package:flutter/material.dart';
import 'package:flutter_anime_tes/pages/home_page.dart';
import 'package:flutter_anime_tes/pages/search_page.dart';
import 'package:flutter_anime_tes/pages/my_list_page.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Color.fromARGB(255, 12, 209, 77), // Warna item yang dipilih
      unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
      backgroundColor: Colors.black, // Tambahkan baris ini
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'My List',
        ),
      ],
      onTap: (index) {
        if (index == selectedIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyListPage()),
            );
            break;
        }
      },
    );
  }
}