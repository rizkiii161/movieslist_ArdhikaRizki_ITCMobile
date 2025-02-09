import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movieslist/services/constans.dart'; 
import 'package:movieslist/views/discover_movies_screen.dart';
import 'package:movieslist/views/my_app_home_screen.dart';
import 'package:movieslist/views/my_movies_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});
  @override
  _AppMainScreenState createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  late final List<Widget> page;
  
  @override
  void initState() {
    page = [
      MyAppHomeScreen(),
      MyMoviesScreen(),
      DiscoverMoviesScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ksecondarycolor,
        elevation: 0,
        iconSize: 28,
        currentIndex: selectedIndex,
        selectedItemColor: kbluecolor,
        unselectedItemColor: ktextcolor.withOpacity(0.6),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Iconsax.video5 : Iconsax.video_add,
            ),
            label: "My Movies",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2 ? Iconsax.search_favorite5 : Iconsax.search_favorite,
            ),
            label: "Discover Movies",
          ),
        ],
      ),
      body: page[selectedIndex],
    );
  }
}
