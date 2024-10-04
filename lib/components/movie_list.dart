import 'package:flutter/material.dart';
import 'package:movieflix/components/movie_poster.dart';
import 'package:movieflix/models/movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String title;
  final double itemWidth;
  final double itemHeight;
  final bool hideTitle;
  final Function(Movie) onTap;

  const MovieList({
    super.key,
    required this.movies,
    required this.title,
    required this.itemWidth,
    required this.itemHeight,
    required this.onTap,
    this.hideTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: hideTitle ? itemHeight + 24 : itemHeight + 40 + 40,
          child: PageView.builder(
            controller: PageController(
              viewportFraction:
                  (itemWidth + 16) / MediaQuery.of(context).size.width,
            ),
            pageSnapping: true,
            padEnds: false,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () => onTap(movies[index]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MoviePoster(
                        movie: movies[index],
                        width: itemWidth,
                        height: itemHeight,
                        hideTitle: hideTitle,
                      ),
                      if (!hideTitle) const SizedBox(height: 8),
                      if (!hideTitle)
                        SizedBox(
                          width: itemWidth,
                          child: Text(
                            movies[index].title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
