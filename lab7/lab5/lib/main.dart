import 'package:flutter/material.dart';
import 'screen/home_screen.dart'; // Chỉ cần import màn hình Home

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const MovieHomeScreen(), // Điểm bắt đầu của ứng dụng
    );
  }
}