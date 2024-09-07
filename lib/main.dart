import 'package:brick_breaker/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//----Step01--- Cleaning the bioler plat code

//----Step02--- Setting up basic Game structure

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
