import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbMovies extends StateNotifier<List<dynamic>> {
  TmdbMovies() : super([]);
  List<dynamic> movie = [];
  final String apikey = '3571895bb749fe1cf693ee4870688dcf';
  final readaccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTcxODk1YmI3NDlmZTFjZjY5M2VlNDg3MDY4OGRjZiIsInN1YiI6IjY1MjNiZWE0MGNiMzM1MTZmNWM1YjY4YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QNUjlq98Rw_-utZA_l1V8w8-VtyGbFoMAOlaedJtNrw';

  void initState() {
    trendingMovies();
  }

  Map<String, dynamic> findById(int id) {
    return movie.firstWhere((element) => element['id'] == id);
  }

  Future<void> trendingMovies() async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(apikey, readaccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );
      final response = await tmdbWithCustomLogs.v3.trending
          .getTrending(mediaType: MediaType.all, timeWindow: TimeWindow.week);
      movie = response['results'];
      state = movie;
    } catch (e) {
      rethrow;
    }
  }
}

final trendingMoviesProvider =
    StateNotifierProvider<TmdbMovies, List<dynamic>>((ref) => TmdbMovies());
