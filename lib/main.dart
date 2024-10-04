import 'package:flutter/material.dart';
import 'package:movieflix/screens/home_screen.dart';

void main() {
  runApp(const Movieflix());
}

class Movieflix extends StatelessWidget {
  const Movieflix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movieflix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
