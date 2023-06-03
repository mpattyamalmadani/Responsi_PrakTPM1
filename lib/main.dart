import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_praktpm/models/favorite_model.dart';
import 'package:responsi_praktpm/screens/splash_screen.dart';

import 'login/login.dart';

void main() async{
  initiateLocalDB();

  runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox<Favorite>('favorite_list');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.blueGrey,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: LoginPage(),
    );
  }}
