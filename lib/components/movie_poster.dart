import 'package:flutter/material.dart';
import 'package:movieflix/models/movie.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;
  final bool hideTitle;

  const MoviePoster({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
    this.hideTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://image.tmdb.org/t/p/w300${movie.posterPath}',
        width: width,
        height: height,
        fit: BoxFit.cover,
        cacheWidth: (width * 1.5).toInt(),
        cacheHeight: (height * 2).toInt(),
        alignment: Alignment.topCenter,
        semanticLabel: movie.title,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey,
            width: width,
            height: height,
            child: Center(
              child: Text(
                movie.title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
