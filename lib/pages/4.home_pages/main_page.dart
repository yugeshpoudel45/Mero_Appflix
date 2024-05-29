import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/pages/4.home_pages/gemini_page.dart';
import 'package:netflix/pages/4.home_pages/explore_page.dart';
import 'package:netflix/pages/4.home_pages/home_page.dart';
import 'package:netflix/pages/4.home_pages/my_list_page.dart';
import 'package:netflix/pages/4.home_pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const ExplorePage(),
    const GeminiPage(),
    const MyListPage(),
    const ProfilePage(),
  ];

  getBody(int index) {
    return pages[index];
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBody(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: myColorScheme.onTertiary,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: selectedIndex == 0
                ? const Icon(Icons.home_filled)
                : const Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 1
                ? const Icon(Icons.explore_rounded)
                : const Icon(Icons.explore_outlined),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 2
                ? const Icon(CupertinoIcons.chat_bubble_fill)
                : const Icon(CupertinoIcons.chat_bubble),
            label: "Gemini",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 3
                ? const Icon(Icons.watch_later_rounded)
                : const Icon(Icons.watch_later_outlined),
            label: "My List",
          ),
          BottomNavigationBarItem(
            icon: selectedIndex == 4
                ? const Icon(CupertinoIcons.person_fill)
                : const Icon(CupertinoIcons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
