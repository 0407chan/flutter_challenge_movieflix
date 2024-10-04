import 'package:flutter/material.dart';
import 'package:movieflix/models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Center(
        child: Text('영화 상세 정보: ${movie.title}'),
      ),
    );
  }
}
