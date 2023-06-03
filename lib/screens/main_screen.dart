import 'package:flutter/material.dart';
import 'package:responsi_praktpm/screens/about_screen.dart';
//import 'package:responsi_praktpm/screens/about_screen.dart';
import 'package:responsi_praktpm/screens/favorite_screen.dart';
import 'package:responsi_praktpm/screens/home_screen.dart';
//import 'package:responsi_praktpm/screens/konversi_screen.dart';
import 'package:responsi_praktpm/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    AboutScreen(),

    // KonversiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value){
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
      ),
    );
  }
}