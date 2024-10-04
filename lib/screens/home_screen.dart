import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/components/movie_list.dart';
import 'package:movieflix/models/movie.dart';
import 'package:movieflix/screens/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> popularMovies = [];
  List<Movie> nowInCinemas = [];
  List<Movie> comingSoon = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void toMovieDetailScreen(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(movie: movie),
      ),
    );
  }

  Future<void> fetchMovies() async {
    final urls = [
      'https://movies-api.nomadcoders.workers.dev/popular',
      'https://movies-api.nomadcoders.workers.dev/now-playing',
      'https://movies-api.nomadcoders.workers.dev/coming-soon',
    ];

    try {
      final responses = await Future.wait(
        urls.map((url) => http.get(Uri.parse(url))),
      );

      setState(() {
        popularMovies = (json.decode(responses[0].body)['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();

        nowInCinemas = (json.decode(responses[1].body)['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();

        comingSoon = (json.decode(responses[2].body)['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      });
      print(popularMovies[0].title);
    } catch (e) {
      print('데이터를 가져오는 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieList(
              movies: popularMovies,
              title: "Popular Movies",
              itemWidth: 320 + 16,
              itemHeight: 240,
              hideTitle: true,
              onTap: toMovieDetailScreen,
            ),
            MovieList(
              movies: nowInCinemas,
              title: "Now in Cinemas",
              itemWidth: 160,
              itemHeight: 160,
              onTap: toMovieDetailScreen,
            ),
            MovieList(
              movies: comingSoon,
              title: "Coming Soon",
              itemWidth: 160,
              itemHeight: 160,
              onTap: toMovieDetailScreen,
            ),
          ],
        ),
      ),
    );
  }
}
