import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie.dart';

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
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Popular Movies",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction:
                      (320 + 16) / MediaQuery.of(context).size.width,
                ),
                pageSnapping: true,
                padEnds: false,
                itemCount: popularMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w300${popularMovies[index].posterPath}',
                        height: 220,
                        width: 320 + 16,
                        fit: BoxFit.cover,
                        cacheHeight: 440,
                        cacheWidth: 320 + 16,
                        alignment: Alignment.topCenter,
                        semanticLabel: popularMovies[index].title,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            width: 300,
                            height: 200,
                            child: Center(
                              child: Text(
                                popularMovies[index].title,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Now in Cinemas",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction:
                      (160 + 16) / MediaQuery.of(context).size.width,
                ),
                pageSnapping: true,
                padEnds: false,
                itemCount: nowInCinemas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200${nowInCinemas[index].posterPath}',
                            height: 160,
                            width: 160,
                            fit: BoxFit.cover,
                            cacheHeight: 240,
                            cacheWidth: 160,
                            alignment: Alignment.topCenter,
                            semanticLabel: nowInCinemas[index].title,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey,
                                width: 160,
                                height: 160,
                                child: Center(
                                  child: Text(
                                    nowInCinemas[index].title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 160,
                          child: Text(
                            nowInCinemas[index].title,
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
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Coming Soon",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 160 + 32 + 50,
              child: PageView.builder(
                controller: PageController(
                  viewportFraction:
                      (160 + 16) / MediaQuery.of(context).size.width,
                ),
                pageSnapping: true,
                padEnds: false,
                itemCount: comingSoon.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200${comingSoon[index].posterPath}',
                            height: 160,
                            width: 160,
                            fit: BoxFit.cover,
                            cacheHeight: 240,
                            cacheWidth: 160,
                            alignment: Alignment.topCenter,
                            semanticLabel: comingSoon[index].title,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey,
                                width: 160,
                                height: 160,
                                child: Center(
                                  child: Text(
                                    comingSoon[index].title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 160,
                          child: Text(
                            nowInCinemas[index].title,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
