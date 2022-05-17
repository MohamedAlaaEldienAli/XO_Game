import 'package:flutter/material.dart';
import 'package:xo_game_app/modules/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00061a),
        shadowColor: const Color(0xFF001456),
        splashColor: const Color(0xFF4169e8),
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
