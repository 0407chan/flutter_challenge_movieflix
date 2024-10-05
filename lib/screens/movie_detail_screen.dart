import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie.dart';
import 'package:movieflix/models/movie_detail.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetail? movieDetail;

  @override
  void initState() {
    super.initState();
    fetchMovieDetail();
  }

  Future<void> fetchMovieDetail() async {
    final response = await http.get(
      Uri.parse(
        'https://movies-api.nomadcoders.workers.dev/movie?id=${widget.movie.id}',
      ),
    );
    final movieDetail = MovieDetail.fromJson(json.decode(response.body));

    setState(() {
      this.movieDetail = movieDetail;
    });
  }

  String getRuntime() {
    if (movieDetail == null) {
      return '';
    }
    final hours = movieDetail!.runtime ~/ 60;
    final minutes = movieDetail!.runtime % 60;
    return '${hours}h ${minutes}min';
  }

  double getRoundedRating() {
    if (movieDetail == null) {
      return 0.0;
    }
    // 10점 만점을 5점 만점으로 변환
    return (movieDetail!.voteAverage / 2).clamp(0.0, 5.0);
  }

  Widget buildStarRating() {
    double rating = getRoundedRating();
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.yellow, size: 30);
        } else if (index < rating.ceil() && rating % 1 != 0) {
          return const Icon(Icons.star_half, color: Colors.yellow, size: 30);
        } else {
          return const Icon(Icons.star_border, color: Colors.yellow, size: 30);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Back to list',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // 뒤로가기 버튼 색상 변경
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://image.tmdb.org/t/p/original${movieDetail?.backdropPath ?? widget.movie.backdropPath}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.25),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 32 + 64,
              left: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    child: Text(
                      widget.movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // 별점
                  buildStarRating(),
                  const SizedBox(height: 24),

                  Text(
                    movieDetail != null
                        ? '${getRuntime()} | ${movieDetail?.genres.map((e) => e.name).join(", ")}'
                        : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // 요약
                  const SizedBox(height: 48),
                  const Text(
                    'Storyline',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        48, // 화면 너비에서 좌우 여백을 뺀 값
                    child: Text(
                      widget.movie.overview ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 32,
              left: 48,
              right: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 226, 59),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Buy ticket',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
