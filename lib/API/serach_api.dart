import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchNotifier extends StateNotifier<List<dynamic>> {
  SearchNotifier() : super([]);
  List<dynamic> searchMovie = [];
  final String apikey = '3571895bb749fe1cf693ee4870688dcf';
  final readaccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTcxODk1YmI3NDlmZTFjZjY5M2VlNDg3MDY4OGRjZiIsInN1YiI6IjY1MjNiZWE0MGNiMzM1MTZmNWM1YjY4YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QNUjlq98Rw_-utZA_l1V8w8-VtyGbFoMAOlaedJtNrw';
  void sortByPopularity(List<dynamic> list) {
    list.sort((a, b) => b['popularity'].compareTo(a['popularity']));
  }

  void sortByRating(List<dynamic> list) {
    list.sort((a, b) => b['vote_average'].compareTo(a['vote_average']));
  }

  void sortByReleaseDate(List<dynamic> list) {
    list.sort((a, b) => b['release_date'].compareTo(a['release_date']));
  }

  void clearList() {
    searchMovie.clear();
    state = searchMovie;
  }

  Future<void> searchMovies(String query) async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(apikey, readaccessToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );
      final response = await tmdbWithCustomLogs.v3.search
          .queryMovies(query, includeAdult: true);
      searchMovie = response['results'];
      state = searchMovie;
    } catch (e) {
      rethrow;
    }
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, List<dynamic>>(
    (ref) => SearchNotifier());
